From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v4 2/2] cap11xx: add LED support
Date: Wed, 17 Jun 2015 10:59:42 +0200
Message-ID: <558136FE.7060308@zonque.org>
References: <1434422770-26896-1-git-send-email-mranostay@gmail.com>	<1434422770-26896-3-git-send-email-mranostay@gmail.com>	<557FD625.1080806@samsung.com>	<CAKzfze9gneY_LmWaWGNKxLXBsw_k2d596CkGNat5RoTbn3cYEg@mail.gmail.com>	<55809476.90407@zonque.org>	<CAKzfze_TXP=qpyXJcktALW4V9b2SxH3qQSs=u3a8Xc=0diZ0Ng@mail.gmail.com>	<CAKzfze8629xyiz1wufjoGbOu+npDRXyCgyGEhxY_1h7XHKeTQg@mail.gmail.com> <CAKzfze-M2aDY8p7FeazC7vBrigBGa-a6k43+=FZ9DEBOD0hHpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <CAKzfze-M2aDY8p7FeazC7vBrigBGa-a6k43+=FZ9DEBOD0hHpw@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 06/17/2015 08:49 AM, Matt Ranostay wrote:
> Actually after further reading of the datasheet and testing with
> i2ctools it seems cap11xx_input_close() isn't putting the device in
> DEEP SLEEP mode.
> 
> Any thoughts why?

No, sorry. IIRC, the board I wrote the driver for didn't give me the
ability to measure power consumption.


Daniel
