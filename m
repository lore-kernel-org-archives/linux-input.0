From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 3/5] input: wacom: Add support for the Bamboo Touch
 trackpad (rev3)
Date: Fri, 3 Sep 2010 17:30:27 +0200
Message-ID: <AANLkTinUxPMezfSHjfPPJ6PoZ1Put26ZAMrzQ36K2fjV@mail.gmail.com>
References: <1283516247-11624-1-git-send-email-rydberg@euromail.se>
	<1283516247-11624-4-git-send-email-rydberg@euromail.se>
	<6753EB6004AFF34FAA275742C104F952022BB10E@wacom-nt10.wacom.com>
	<4C80F2CD.2040708@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C80F2CD.2040708@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pingc@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 3, 2010 at 3:06 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> On 09/03/2010 03:01 PM, Ping Cheng wrote:
> [...]
>
>> + =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D 0)=
;
>> + =A0 =A0 input_report_key(input, BTN_MIDDLE, (data[1] & 0x04) !=3D =
0);
>> + =A0 =A0 input_report_key(input, BTN_4, (data[1] & 0x02) !=3D 0);
>> + =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=3D 0=
);
>>
>> Since you are assigning meaningful defaults to three of the tablet
>> buttons instead of using BTN_#, can we move one more step to make th=
e
>> fourth button useful out-of-box too? I am thinking of something like
>> BTN_FORWARD and BTN_BACK while getting rid of the BTN_MIDDLE. So, it
>> would be:
>>
>> =A0 =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D =
0);
>> =A0 =A0 =A0 input_report_key(input, BTN_FORWARD, (data[1] & 0x04) !=3D=
 0);
>> =A0 =A0 =A0 input_report_key(input, BTN_BACK, (data[1] & 0x02) !=3D =
0);
>> =A0 =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=3D=
 0);
>>
>> Does this make sense to you?
>
>
> Well, this is all a matter of taste, isn't it. If middle-button emula=
tion works
> out of the box, for the benefit of us old X users who seem unwilling =
to ever let
> go of the click-to-paste functionality, then I would not mind terribl=
y.

I agree and I use middle click more than right click myself ;). I just
wanted to give BTN_4 a life. If no one has a good suggestion for that,
I can live with it.

Ping
