From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] HID: wacom: correct misreported EKR ring values
Date: Mon, 19 Aug 2019 15:03:49 -0400
Message-ID: <20190819190349.GE30205@sasha-vm>
References: <1566232914-9919-1-git-send-email-aaron.skomra@wacom.com>
 <20190819170246.GA30205@sasha-vm>
 <CAEoswT3mvABD7T_0WkwrAOe1PHO62jZ63tUb2UBQLm_Tqu-guw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEoswT3mvABD7T_0WkwrAOe1PHO62jZ63tUb2UBQLm_Tqu-guw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, "Cheng, Ping" <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>, "# v4 . 3+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 19, 2019 at 10:13:31AM -0700, Aaron Armstrong Skomra wrote:
>On Mon, Aug 19, 2019 at 10:02 AM Sasha Levin <sashal@kernel.org> wrote:
>
>> On Mon, Aug 19, 2019 at 09:41:54AM -0700, Aaron Armstrong Skomra wrote:
>> >The EKR ring claims a range of 0 to 71 but actually reports
>> >values 1 to 72. The ring is used in relative mode so this
>> >change should not affect users.
>> >
>> >Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
>> >Fixes: 72b236d60218f ("HID: wacom: Add support for Express Key Remote.")
>> >Cc: <stable@vger.kernel.org> # v4.3+
>> >Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
>> >Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
>> >---
>> >Patch specifically targeted to v4.9.189
>>
>> Is this not a problem upstream as well? Why not?
>>
>> If it is, this patch will need to go upstream first, and then it'll get
>> to stable branches from there.
>>
>> Hi Sasha,
>I neglected my "--in-reply-to" in git send-email, I will resend. My
>apologies.

Ah, I see what happened. Looks good now, thanks!
