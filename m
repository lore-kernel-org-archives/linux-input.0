From: "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Date: Tue, 8 Jan 2019 17:20:13 +0000
Message-ID: <20190108172013.GA13290@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
 <20190107164225.GA5394@agonzal-linux> <20190107185607.GA141497@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107185607.GA141497@dtor-ws>
Content-Language: en-US
Content-ID: <0EB1086BE73FA14DAE97C15A4442E3B3@digi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

>
>My concern with trying to do the address selection without RST line is
>that it is quite unreliable, as it really depends on timings between the
>chip reset, INT line being driven by the host and then being switched to
>input.

I think you are right. thinking twice I should be able to fake the reset line
by controlling a regulator to the voltage source for the pull-up. It seems a 
more solid solution.

Thanks a lot for your help and sorry for the noise.

Alex
