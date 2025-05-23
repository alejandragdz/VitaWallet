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
        curl -H "Content-Type:application/json" http://localhost:3000/users -X POST -d '{"user": {"name": "Juan", "usd_wallet": 100.0, "btc_wallet": 100.0}}'
    - Ver todos los usuarios
        curl -L http://localhost:3000/users
    - Ver todas las transacciones:
        curl -L http://localhost:3000/transactions
    - Ver una transacción en específico **(Detalle de transacción)**:
        curl -L http://localhost:3000/transactions/1
    - Nueva transacción:
        curl -H "Content-Type:application/json" http://localhost:3000/transactions -X POST -d '{"transaction": {"sender_id": 1, "receiver_id": 2, "coin_to_send": "usd", "coin_to_receive": "btc", "amount_to_send": 10}}'

## Prueba de endpoints en Postman:
    https://vitawallet-challenge.postman.co/workspace/VitaWallet-Challenge-Workspace~3fe896bf-0b43-456a-83b7-a2a5b640da08/collection/36286241-1e469890-6405-4d0b-afe6-434ea8a49f0a?action=share&creator=36286241
