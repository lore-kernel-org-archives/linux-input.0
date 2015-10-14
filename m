From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCHv9 07/15] cec: add HDMI CEC framework
Date: Wed, 14 Oct 2015 08:29:44 +0200
Message-ID: <561DF658.3090002@xs4all.nl>
References: <cover.1441633456.git.hansverk@cisco.com> <60de2f33f0d4c809f06d23cdac75e3b798aaae4b.1441633456.git.hansverk@cisco.com> <20151006170635.GQ21513@n2100.arm.linux.org.uk> <561B9B1A.4020001@xs4all.nl> <20151013225147.GM32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20151013225147.GM32532@n2100.arm.linux.org.uk>
Sender: linux-media-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hans Verkuil <hansverk@cisco.com>, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, thomas@tommie-lie.de, sean@mess.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, lars@opdenkamp.eu, kamil@wypas.org, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

On 10/14/2015 12:51 AM, Russell King - ARM Linux wrote:
> On Mon, Oct 12, 2015 at 01:35:54PM +0200, Hans Verkuil wrote:
>> On 10/06/2015 07:06 PM, Russell King - ARM Linux wrote:
>>> Surely you aren't proposing that drivers should write directly to
>>> adap->phys_addr without calling some notification function that the
>>> physical address has changed?
>>
>> Userspace is informed through CEC_EVENT_STATE_CHANGE when the adapter is
>> enabled/disabled. When the adapter is enabled and CEC_CAP_PHYS_ADDR is
>> not set (i.e. the kernel takes care of this), then calling CEC_ADAP_G_PHYS_ADDR
>> returns the new physical address.
> 
> Okay, so when I see the EDID arrive, I should be doing:
> 
>                 phys = parse_hdmi_addr(block->edid);
>                 cec->adap->phys_addr = phys;
>                 cec_enable(cec->adap, true);
> 
> IOW, you _are_ expecting adap->phys_addr to be written, but only while
> the adapter is disabled?

Right.

And when the hotplug goes down you should call cec_enable(cec->adap, false).
While the adapter is disabled, CEC_ADAP_G_PHYS_ADDR will always return
CEC_PHYS_ADDR_INVALID regardless of the cec->adap->phys_addr value.

Regards,

	Hans
