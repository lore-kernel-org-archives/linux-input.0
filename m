From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 17:19:11 +0200
Message-ID: <a8fe033e-02dd-bf26-ec49-6f271657efda@redhat.com>
References: <87eg9j6zf7.fsf@smart-cactus.org> <20160525073949.GY29844@pali>
 <87a8jejq3u.fsf@smart-cactus.org> <201605251645.47346@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900AbcEYPTS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 11:19:18 -0400
In-Reply-To: <201605251645.47346@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Ben Gamari <ben@smart-cactus.org>, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Allen_Hung@dell.com, Mario_Limonciello@dell.com, linux-input@vger.kernel.org

Hi,

On 25-05-16 16:45, Pali Roh=C3=A1r wrote:
> On Wednesday 25 May 2016 14:09:57 Ben Gamari wrote:
>>     [  714.781858] psmouse: psmouse serio1: alps: E6 report: 00 00 6=
4
>>     [  714.804749] psmouse: psmouse serio1: alps: E7 report: 73 03 2=
8
>>     [  714.830829] psmouse: psmouse serio1: alps: EC report: 73 01 1=
3
>>     [  714.833568] psmouse: psmouse serio1: alps: Likely not an ALPS=
 touchpad: E7=3D73 03 28, EC=3D73 01 13
>
> Great! This allow us to identify touchpad more precious.
>
> Adding people who signed/acked alps commit which added V8 protocol
> support. Above touchpad should has V8 protocol too. And it is with
> trackstick.
>
> Any idea why is not recognized?

This is likely one of the new hid based touchpad / trackstick combo-s.

See this mail (and attached patch):

http://www.spinics.net/lists/linux-input/msg44764.html

=46or a driver for this. If the reporter can build a test-kernel with t=
his
patch and let us know if that makes things work, that would be great.

If the reporter is running Fedora I can provide a test-kernel with
this patch.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
