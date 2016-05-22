From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Sun, 22 May 2016 17:35:42 +0800
Message-ID: <1463909742-371-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <20160513041852.GA8932@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160513041852.GA8932@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry:

>> 		if (len < RM_BL_WRT_PKG_SIZE) {
>> 			buf[BL_PKG_IDX] = 4;

>Why 4???
4 is trigger index for write flash. Our page write size is 128 bytes, 
but in order to meet maximum I2C bus read/write byte limite and need 
fill full all pages of 128 bytes. So that I split 128 bytes to "4" 
section, and start burning flash if touch MCU get index "4". 
