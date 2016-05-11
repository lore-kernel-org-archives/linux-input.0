From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Thu, 12 May 2016 00:04:01 +0800
Message-ID: <1462982641-372-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <1461923113-426-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461923113-426-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry:

I've made a mistake as touch points data over "MAX_PKG_SIZE".This mista=
ke will result in memory overwrite, so that I update a new patch to ups=
tream.=20
New patch I assign a new definition "MAX_RD_PKG_LEN" for maxinum I2C re=
ad command to prevent touch points data package over I2C bus buffer siz=
e. If I2C read command package over than MAX_RD_PKG_LEN, I=E2=80=99ll s=
plit this read command two or more to make sure all data are read.

Please review my new patch and give me some comments. Many thanks.
