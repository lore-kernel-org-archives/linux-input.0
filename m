From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Support for the eGalax dual-touch panel
Date: Mon, 12 Apr 2010 09:19:55 +0200
Message-ID: <z2g8f7062ad1004120019g9dbd9069m8b5f9dfcba64f1c9@mail.gmail.com>
References: <20100410144308.9ABEE951F6@smtp.lii-enac.fr>
	 <1270915489.3869.12.camel@lovely>
	 <4E18664F-5C63-4A5B-AFC8-12CC9FD0FA3A@enac.fr>
	 <20100412032158.GE29292@core.coreip.homeip.net>
	 <r2l8f7062ad1004120015h21632b7v65deeae98cb1739a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:50428 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0DLHT5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Apr 2010 03:19:57 -0400
Received: by wwi17 with SMTP id 17so1968913wwi.19
        for <linux-input@vger.kernel.org>; Mon, 12 Apr 2010 00:19:55 -0700 (PDT)
In-Reply-To: <r2l8f7062ad1004120015h21632b7v65deeae98cb1739a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

2010/4/12 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> On Sat, Apr 10, 2010 at 08:00:59PM +0200, St=E9phane Chatty wrote:
>>
>> Le 10 avr. 10 =E0 18:04, Christoph Fritz a =E9crit :
>>
>> >Am Samstag, den 10.04.2010, 16:43 +0200 schrieb Stephane Chatty:
>> >>Added support for the eGalax dual-touch panel, found on the Asus
>> >>EeePC T101MT
>> >
>> >>+static void egalax_remove(struct hid_device *hdev)
>> >>+{
>> >>+ =A0 hid_hw_stop(hdev);
>> >>+ =A0 kfree(hid_get_drvdata(hdev));
>> >>+ =A0 hid_set_drvdata(hdev, NULL);
>> >>+}
>> >
>> >Why not using hid_hw_stop() instead of hid_set_drvdata()?
>> >
>
> It is used 2 lines above, isn't it?

sure, that's why I asked (overdetermined)

>
>>
>> Er, actually for a previous driver Dmitry suggested to add this line
>> and I did it without trying to understand :-)
>>
>
> You normally want to reset any pointers you set before, unless core d=
oes
> this for you. As far as I know only i2c guys decided to move that int=
o
> core so far.

Should we do this too in a long run?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
