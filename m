From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] i2c-hid: introduce HID over i2c specification implementation
Date: Mon, 19 Nov 2012 11:23:49 +0100
Message-ID: <CAN+gG=FurTLa8jJpMti6+cp60RZ6+TB7HxNfQMX1P20cFcGWHA@mail.gmail.com>
References: <1352731379-24683-1-git-send-email-benjamin.tissoires@gmail.com>
	<alpine.LNX.2.00.1211191106020.20577@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1211191106020.20577@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Nov 19, 2012 at 11:06 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Mon, 12 Nov 2012, Benjamin Tissoires wrote:
>
>> Microsoft published the protocol specification of HID over i2c:
>> http://msdn.microsoft.com/en-us/library/windows/hardware/hh852380.aspx
>>
>> This patch introduces an implementation of this protocol.
>>
>> This implementation does not includes the ACPI part of the specification.
>> This will come when ACPI 5.0 devices enumeration will be available.
>>
>> Once the ACPI part is done, OEM will not have to declare HID over I2C
>> devices in their platform specific driver.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> ---
>>
>> Hi Guys,
>>
>> here is the v3 of the HID over I2C driver.
>>
>> Changes in v3:
>> * fix i2c_hid_alloc_buffers when allocation failed
>> * fix error messages to be more "human"
>> * fix i2c_hid_set_report as it didn't followed the protocol
>> * remove i2c_hid_write_out_report (hid-core doesn't present the callback that
>> could use this feature of the protocol)
>> * reject HID_OUTPUT_REPORT in i2c_hid_get_raw_report
>> * fix output report id in i2c_hid_output_raw_report and reject HID_INPUT_REPORT
>
> Benjamin,
>
> I am now queuing this in for-3.8/i2c-hid branch, so please send any
> potential followup patches on top of that.

Ok, thanks a lot Jiri.

Cheers,
Benjamin

>
> Thanks a lot for all your work on this so far.
>
> --
> Jiri Kosina
> SUSE Labs
