From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] HID: alps: fix stick device not working after resume
Date: Mon, 19 Sep 2016 23:57:54 +0800
Message-ID: <CAAd53p54k3JMEBNqVF3UR9NGwLNuuh9P_vMh8NoggFUfwCoADA@mail.gmail.com>
References: <20160919074139.2551-1-kai.heng.feng@canonical.com> <alpine.LNX.2.00.1609191436370.22028@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1609191436370.22028@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

On Mon, Sep 19, 2016 at 8:37 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Mon, 19 Sep 2016, Kai-Heng Feng wrote:
>
>> The stick device does not work after resume, add U1_SP_ABS_MODE flag can
>> make the device work after resume.
>
> Do you happen to have any more details on why it doesn't work without
> U1_SP_ABS_MODE? Or was this a pure guesswork?

It' pure guesswork, based on how the existing code uses U1_TP_ABS_MODE flag
on both initialization and resume.

I also tested the the patch on an ALPS touchpad without stick device,
did not notice
any side effect on suspend/resume, so I made the U1_SP_ABS_MODE flag mandatory.

>
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/hid/hid-alps.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
>> index 048befd..390f8d3 100644
>> --- a/drivers/hid/hid-alps.c
>> +++ b/drivers/hid/hid-alps.c
>> @@ -244,13 +244,13 @@ static int alps_raw_event(struct hid_device *hdev,
>>  static int alps_post_reset(struct hid_device *hdev)
>>  {
>>       return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
>> -                             NULL, U1_TP_ABS_MODE, false);
>> +                             NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
>>  }
>>
>>  static int alps_post_resume(struct hid_device *hdev)
>>  {
>>       return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
>> -                             NULL, U1_TP_ABS_MODE, false);
>> +                             NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
>>  }
>>  #endif /* CONFIG_PM */
>
> --
> Jiri Kosina
> SUSE Labs
>
