From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Fri, 19 Aug 2011 15:39:09 +0200
Message-ID: <4E4E677D.5000102@tudelft.nl>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw> <20110818173959.GE28313@thinkpad-t410> <87hb5ddcsa.fsf@emc.com.tw> <20110819121308.GA16386@thinkpad-t410> <4E4E59DD.7000005@tudelft.nl> <20110819125025.GA17925@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:45182 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab1HSNjL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 09:39:11 -0400
In-Reply-To: <20110819125025.GA17925@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>Tom Lin <t>

Op 19-08-11 14:50, Seth Forshee schreef:
>>
>> Yes, in other words, in the case of v1 or v2, the switch(fingers)
>> does nothing if fingers =3D=3D 0.
>>
>> Maybe you could do put these 3 lines inside a "if (fingers !=3D 0)":
>> +	input_report_abs(dev, ABS_X, x1);
>> +	input_report_abs(dev, ABS_Y, y1);
>> +	elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
>
> I don't think elantech_report_semi_mt_data() should be moved inside t=
he
> condition. It's doing the right thing when fingers is 0.
Oh, right, it already tests for this case :-) My mistake.

=C3=89ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
