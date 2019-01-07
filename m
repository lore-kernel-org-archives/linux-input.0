From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Mon, 07 Jan 2019 17:01:56 +0100
Message-ID: <5dfd17505a7c2f650f1102a8c0d7008ca8dc0b1f.camel@hadess.net>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
         <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
         <20190105225147.le5fgpnvq7sctxe5@penguin>
         <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alex Gonzalez <alex.gonzalez@digi.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2019-01-07 at 16:56 +0100, Bastien Nocera wrote:
> Given that we do have access to the datasheet, it would also be
> useful
> for the patch to mention where in the datasheet it says that the
> reset
> line can be left pulled-up, or mention on which shipping device this
> setup is already used (and if so, what the DTS or ACPI snippet that
> declares those is).

Or alternatively, and as Andreas pointed out in another thread, find
the code in the vendor driver that does support this setup:
https://github.com/goodix/gt9xx_driver_android
https://github.com/goodix/goodix_gt9xx_public

If it doesn't work with the vendor code, then we might not want to make
it work with our driver either.

Cheers
