From: "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Mon, 7 Jan 2019 16:44:09 +0000
Message-ID: <20190107164408.GA5564@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
 <5dfd17505a7c2f650f1102a8c0d7008ca8dc0b1f.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5dfd17505a7c2f650f1102a8c0d7008ca8dc0b1f.camel@hadess.net>
Content-Language: en-US
Content-ID: <B2493A6C59AF6C4CA6F062DD60749A95@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

>
>If it doesn't work with the vendor code, then we might not want to make
>it work with our driver either.
>

Thanks Bastien. The vendor code does seem to require both INT and RESET gpios.
