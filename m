From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Date: Fri, 14 Oct 2011 07:58:37 -0700
Message-ID: <CANLzEksars=PfOdx6Uxu-FbmxuXK0DMZoGW0HWbpogQ11YAA1Q@mail.gmail.com>
References: <Pine.LNX.4.44L0.1110140955030.2036-100000@iolanthe.rowland.org>
	<alpine.LNX.2.00.1110141559220.14768@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:40757 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040Ab1JNO6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 10:58:39 -0400
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com [172.24.198.85])
	by smtp-out.google.com with ESMTP id p9EEwcfo019472
	for <linux-input@vger.kernel.org>; Fri, 14 Oct 2011 07:58:38 -0700
Received: from qyk34 (qyk34.prod.google.com [10.241.83.162])
	by wpaz21.hot.corp.google.com with ESMTP id p9EEvl7d003194
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 14 Oct 2011 07:58:38 -0700
Received: by qyk34 with SMTP id 34so3437253qyk.2
        for <linux-input@vger.kernel.org>; Fri, 14 Oct 2011 07:58:37 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1110141559220.14768@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks for the prompt response.

My initial reasoning was to set as default the wakeup behavior so a
mouse button press would wake the system. I am well aware that most if
not all mice don't support wake on move, but at least wake on button
press would have been more desirable than doing nothing.

Anyway, I'll solve this problem on my system by writing to wakeup
property on device attach. Consider my change abandoned.

Thanks,
Benson

On Fri, Oct 14, 2011 at 7:00 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 14 Oct 2011, Alan Stern wrote:
>
>> In addition, unlike keyboards, a lot of mice don't work very well wh=
en
>> they are suspended. =A0For example, many won't wake up when they are
>> moved (especially optical mice) and some don't even wake up when a
>> button is pressed.
>
> To stress it even more, I have tried with various types and brands of
> optical mouse, and I haven't encountered a single one that would wake=
 up
> when moved.
>
>> This patch definitely should not be merged.
>
> I am not planning to do that.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>



--=20
Benson Leung
Software Engineer,=A0Chrom* OS
bleung@chromium.org
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
