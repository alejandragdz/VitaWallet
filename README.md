# VitaWallet

## Configuración
    rails (~> 8.0.2)
    ruby 3.4.4

## **RSPEC**: Pruebas
    - Mostrar toda la covertura de las pruebas
        `bundle exec rspec --format documentation`
    - Pruebas a los endpoints
        - Transactions
            `bundle exec rspec spec/requests/transactions_spec.rb --format documentation`
        - Users
            `bundle exec rspec spec/requests/transactions_spec.rb --format documentation`

## **Endpoints**: Prueba con curl
    - Nuevo usuario 
        `curl -H "Content-Type:application/json" http://localhost:3000/users -X POST -d '{"user": {"name": "Juan", "usd_wallet": 100.0, "btc_wallet": 100.0}}'`
    - Ver todos los usuarios
        `curl -L http://localhost:3000/users`
    - Ver todas las transacciones:
        `curl -L http://localhost:3000/transactions`
    - Ver una transacción en específico **(Detalle de transacción)**:
        `curl -L http://localhost:3000/transactions/1`
    - Nueva transacción:
        `curl -H "Content-Type:application/json" http://localhost:3000/transactions -X POST -d '{"transaction": {"sender_id": 1, "receiver_id": 2, "coin_to_send": "usd", "coin_to_receive": "btc", "amount_to_send": 10}}'`
    