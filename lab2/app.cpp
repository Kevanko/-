#include <iostream>
#include <csignal>
#include <unistd.h>

volatile std::sig_atomic_t signal_received = 0;

void signal_handler(int signal) {
    std::cout << "Received signal: " << signal << std::endl;
    signal_received = signal;
}

int main() {
    std::signal(SIGTERM, signal_handler);
    std::signal(SIGINT, signal_handler);

    std::cout << "Running... Press Ctrl+C to stop." << std::endl;

    while (!signal_received) {
        std::cout << "Working..." << std::endl;
        sleep(2);
    }

    std::cout << "Shutting down gracefully..." << std::endl;
    return 0;
}
