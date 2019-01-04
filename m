From: Alex Gonzalez <alex.gonzalez@digi.com>
Subject: [PATCH] Input: goodix - decouple irq and reset lines
Date: Fri, 4 Jan 2019 17:00:47 +0100
Message-ID: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hadess@hadess.net
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, alex.gonzalez@digi.com
List-Id: linux-input@vger.kernel.org

The current implementation on the Goodix driver requires the two optional GPIOs
(RESET and INT) to be provided.

However, it is possible to designs the RESET line pulled-up and only provide
the INT line. Such designs do not work with the current implementation.

The patch attached allows for designs that only provide the INT line to have
a functional touch on the default I2C address, even though some functionality
like the sleep mode will not be available.

This has been tested on v4.20 with a gt911 based touch panel design that only
provides the INT line.

Alex Gonzalez (1):
  Input: goodix - decouple irq and reset lines

 drivers/input/touchscreen/goodix.c | 59 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 28 deletions(-)
