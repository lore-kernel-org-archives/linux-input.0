From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 0/2] HID: huion: add libinput support
Date: Tue, 24 Feb 2015 13:22:37 +0200
Message-ID: <54EC5EFD.5040505@gmail.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com> <54E45A82.7090706@gmail.com> <20150218200417.GC5928@mail.corp.redhat.com> <54E5CEE9.1050909@gmail.com> <20150220053458.GA23069@jelly.redhat.com> <54E9CCB1.9000705@gmail.com> <20150222232817.GA1645@jelly.redhat.com> <20150223223453.GA28675@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:40890 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbBXLWn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 06:22:43 -0500
In-Reply-To: <20150223223453.GA28675@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 02/24/2015 12:34 AM, Benjamin Tissoires wrote:
> On Feb 23 2015 or thereabouts, Peter Hutterer wrote:
>> yeah, but the thing is: those emails are only necessary _once_  per tablet.
>> if they're not in the database, you'll get those questions for the lifetime
>> of the tablet :)
>>
>> Also note that libwacom_new_from_path() has a fallback option, you can get a
>> generic tablet from it and then proceed as normal. gnome-settings-daemon
>> already uses this.
>>
>
> I also expects that the settings configuration tool under wayland will
> rely on the actual capability of the devices. This way, even if the
> tablet is not registered in libwacom, we will still be able to show a
> default configuration UI.
>
> I really believe the registering in libwacom will be just to have a
> prettier interface, not a requirement.

Well, that sounds awesome! Just what I was looking for :)

What about X.org though? Last time I tried I couldn't configure a
Wacom-handled Huion with the Gnome applet.

Nick
