From: Neil Leeder <nleeder@codeaurora.org>
Subject: [PATCH v3 0/1] input: mouse: add qci touchpad driver
Date: Fri, 27 Aug 2010 12:06:12 -0400
Message-ID: <4C77E274.1090206@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>
List-Id: linux-input@vger.kernel.org

v2: http://lkml.indiana.edu/hypermail/linux/kernel/1008.1/01838.html

Changes since v2:
use #define for wait length during init, as suggested by Shubhrajyoti Datta
add error check from gpio_direction_input
move struct i2c_device_id closer to its use in i2c_driver, for clarity

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
