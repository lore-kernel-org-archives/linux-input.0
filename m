From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/2] HID: wacom: patches for 4.11
Date: Tue, 14 Mar 2017 18:38:42 -0700
Message-ID: <CAF8JNh+bwaDr+1oO=c0R2=X7HfPc_apvTRXQNX_3uo9d2ANizQ@mail.gmail.com>
References: <1488826498-8578-1-git-send-email-skomra@gmail.com> <20170307103416.GB24124@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f176.google.com ([74.125.82.176]:34810 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOBjD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 21:39:03 -0400
Received: by mail-ot0-f176.google.com with SMTP id o24so3702342otb.1
        for <linux-input@vger.kernel.org>; Tue, 14 Mar 2017 18:39:03 -0700 (PDT)
In-Reply-To: <20170307103416.GB24124@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>

Hi Jiri,


On Tue, Mar 7, 2017 at 2:34 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Mar 06 2017 or thereabouts, Aaron Armstrong Skomra wrote:
>> Two fixes for patches included in 4.11
>>
>> Aaron Armstrong Skomra (2):
>>   HID: wacom: Correct Intuos Pro 2 resolution
>>   HID: wacom: don't manually release resources for the EKR
>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Aaron told me about the issue in patch 2/2, so it's not news to me.
>
> Cheers,
> Benjamin
>
>>
>>  drivers/hid/wacom_sys.c | 4 +++-
>>  drivers/hid/wacom_wac.c | 4 ++--
>>  2 files changed, 5 insertions(+), 3 deletions(-)

I don't see the two patches under for-4.11/upstream-fixes. Do you have
questions about the patches?

Cheers,
Ping

>>
>> --
>> 2.7.4
>>
