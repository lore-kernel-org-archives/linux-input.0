From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: RE: [PATCH V2] input: da9063: report KEY_POWER instead of KEY_SLEEP
 during power key-press
Date: Mon, 14 Dec 2015 10:28:24 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB70173D28771@SW-EX-MBX02.diasemi.com>
References: <20151210093632.5DF333FBD7@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151210093632.5DF333FBD7@swsrvapps-01.diasemi.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LINUX-INPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Regarding:
> To: Dmitry Torokhov; LINUX-INPUT; LINUXKERNEL
> Subject: [PATCH V2] input: da9063: report KEY_POWER instead of KEY_SLEEP during power key-press

Hi Dmitry,
Thanks for your Signed-off-by and merge.
Regards,
Steve

repo linux-next
tag next-20151214
commit f889beaaab1ce2ff9d018302359abb345f49be29
Author: Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Sat Dec 12 20:43:35 2015 -0800

    Input: da9063 - report KEY_POWER instead of KEY_SLEEP during power key-press
    
    Stop reporting KEY_SLEEP for a short key-press and report KEY_POWER instead
    This change applies to both DA9063 and DA9062 ONKEY drivers.
    
    A previous application used for testing by the developer required a
    KEY_SLEEP and KEY_POWER input_report_key event to distinguish between a
    short and long key-press of the power key.  This is not the general
    convention and the typical solution is for KEY_POWER to be used in both
    cases: suspend and S/W power off.
    
    Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
    Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
