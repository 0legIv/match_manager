FROM bitwalker/alpine-elixir:1.7.4 AS builder
WORKDIR /source

ARG MIX_ENV=prod
ENV MIX_ENV=${MIX_ENV}

COPY . .
RUN mix clean && \
    mix deps.get && \
    mix compile && \
    mix distillery.release --env=${MIX_ENV}

FROM bitwalker/alpine-erlang:21.1.1

ARG VERSION=0.1.0
ARG MIX_ENV=prod

ENV HOME=app \
    MIX_ENV=${MIX_ENV} \
    DATA_FILE="data.csv" \
    PORT=4001 \
    REPLACE_OS_VARS=true 

WORKDIR /${HOME}
COPY --from=builder /source/_build/${MIX_ENV}/rel/match_manager/releases/${VERSION}/match_manager.tar.gz /tmp/
RUN tar -xf /tmp/match_manager.tar.gz --directory . \
    && rm /tmp/match_manager.tar.gz

ENTRYPOINT ["bin/match_manager"]
CMD ["console"]
