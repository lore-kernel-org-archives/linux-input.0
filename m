From: Philipp Puschmann <pp@emlix.com>
Subject: Re: [PATCH] Input: ili251x - add support for Ilitek ILI251x
 touchscreens
Date: Tue, 15 May 2018 16:31:02 +0200
Message-ID: <ea37e29e-5cf4-5135-041d-b8be20cc17f2@emlix.com>
References: <20180507131823.28800-1-pp@emlix.com>
 <20180509224152.GB91762@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509224152.GB91762@dtor-ws>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh@kernel.org, mark.rutland@arm.com, rydberg@bitmath.org, andi@etezian.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,
hi Rob,
hi Andi,

thank you for your replies and your helpful hints. I will take care of them and
send a V2 of this driver + dt-bindings soon. As i have a working version of this
driver working on it has not a very priority so it may need some time.

Most of your points are correct and don't need further discussion. For the pressure
data i'm unsure, see below.

Am 10.05.2018 um 00:41 schrieb Dmitry Torokhov:
>> The usage of pressure is optional. Touchscreens may deliver constant
>> and so useless pressure data.
> 
> Is it dependent on model or what? I would much rather we did not have DT
> property for this.
I don't know. My touchscreen here delivers a constant (useless) pressure of
10. So my chip delivers "something". I'm not sure if the chip always delivers
no real pressure data or if this is dependent from the wiring.
This was the reason i put it in the dt.


Thanks
Philipp

-- 
Bitte beachten Sie unsere neue Adresse am Göttinger Standort:
emlix GmbH, Gothaer Platz 3, 37083 Göttingen

Philipp Puschmann, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Goettingen HR B 3160
Geschaeftsführung: Heike Jordan, Dr. Uwe Kracke
Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source
