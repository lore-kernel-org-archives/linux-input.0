From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Two regressions on BYT/T ASUS T100TA 4.12-rc: #2 Keyboard no
 longer works
Date: Fri, 9 Jun 2017 10:57:21 +0200
Message-ID: <64bc80d3-9383-50f6-5539-cac5c0998acb@redhat.com>
References: <20170608203904.73abb5e1@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.44L0.1706081545040.1949-100000@iolanthe.rowland.org>
 <CA+55aFzhO9fPORL_yKFFuS-q2WbsjeT7_f_uorUN9ZnXVkH3qw@mail.gmail.com>
 <0d3a087b-ee57-05be-a32a-a5610127db71@redhat.com>
 <alpine.LSU.2.20.1706090959150.30709@cbobk.fhfr.pm>
 <20170609082703.GA29271@kroah.com> <8760g5ilut.fsf@miraculix.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdFII51 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Jun 2017 04:57:27 -0400
In-Reply-To: <8760g5ilut.fsf@miraculix.mork.no>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>, Greg KH <greg@kroah.com>
Cc: Jiri Kosina <jikos@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, USB list <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On 09-06-17 10:52, Bjørn Mork wrote:
> Greg KH <greg@kroah.com> writes:
> 
>> On Fri, Jun 09, 2017 at 10:21:47AM +0200, Jiri Kosina wrote:
>>> Longer-term, we'd ideally make 'generic' driver special and let it attach
>>> as a 'last resort driver' if none of the specific driver picked the device
>>> up during probe. But I don't think our current driver model allows this
>>> easily ... or is there way I am not seeing?
>>
>> Nope, the driver model does not provide a way for this, sorry, it's been
>> a complaint from the very beginning that we don't really know how to
>> handle, except to make sure the order of the drivers loaded are the
>> priority list, and that's not really a solution at all.
> 
> Add a 'priority' field to struct device_driver and sort the list by this
> field instead of load order?

It is not that easy, e.g. with the HID use-case in question the
generic HID driver will typically be built-in where as the vendor
specific drivers will be modules, so you don't know if a higher
priority driver may show up later...

TBH I think that just adding a bunch of #ifdef's to the
hid_have_special_driver array may be best (esp. for 4.12)

Regards,

Hans
