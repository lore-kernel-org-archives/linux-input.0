From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 0/2] input: convert to c99 format
Date: Mon, 17 Sep 2012 19:47:59 +0530
Message-ID: <1347891481-18086-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, Shubhrajyoti D <shubhrajyoti@ti.com>
List-Id: linux-input@vger.kernel.org

The series tries to convert the i2c_msg to c99 struct.
This may avoid issues like below if someone tries to add an
element to the structure.
http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg08972.html

Special thanks to Julia Lawall for helping it automate.
By the below script.
http://www.mail-archive.com/cocci@diku.dk/msg02753.html

Checkpatch warn of more than 80 chars have been ignored.
 

Shubhrajyoti D (2):
  input: Convert struct i2c_msg initialization to C99 format
  input: Convert struct i2c_msg initialization to C99 format

 drivers/input/joystick/as5011.c           |    6 +++---
 drivers/input/touchscreen/cy8ctmg110_ts.c |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.5.4
