package by.sysdialog.auth.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.oauth2.jwt.ReactiveJwtDecoder;
import org.springframework.security.oauth2.jwt.ReactiveJwtDecoders;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.security.web.server.csrf.CookieServerCsrfTokenRepository;

@Configuration
@EnableWebFluxSecurity
public class SecurityConfiguration {

  @Bean
  public SecurityWebFilterChain apiSecurityFilterChain(ServerHttpSecurity http) {
    return http.authorizeExchange()
        .pathMatchers("/api/**")
        .authenticated()
        .and()
        .oauth2ResourceServer()
        .jwt()
        .and()
        .and()
        .csrf()
        .csrfTokenRepository(CookieServerCsrfTokenRepository.withHttpOnlyFalse())
        .and()
        .build();
  }

  @Bean
  public ReactiveJwtDecoder jwtDecoder(
      @Value("${spring.security.oauth2.resourceserver.jwt.issuer-uri}") String issuer) {
    return ReactiveJwtDecoders.fromOidcIssuerLocation(issuer);
  }
}
