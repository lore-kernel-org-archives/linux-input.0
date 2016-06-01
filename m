From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] i2c_hid: enable i2c-hid devices to suspend/resume
 asynchronously
Date: Wed, 1 Jun 2016 10:04:17 +0800
Message-ID: <574E42A0.9080902@linux.intel.com>
References: <573D2900.6090903@linux.intel.com>
 <alpine.LNX.2.00.1605241223460.31937@cbobk.fhfr.pm>
 <CAE_wzQ-Rwpf3Cb8cpw11s=rcRTMZ5kpod7jLAhF84A82CLaVcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE_wzQ-Rwpf3Cb8cpw11s=rcRTMZ5kpod7jLAhF84A82CLaVcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Duggan <aduggan@synaptics.com>, k.kozlowski@samsung.com, Doug Anderson <dianders@chromium.org>, gabriele.mzt@gmail.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



On 5/25/2016 1:31 AM, Dmitry Torokhov wrote:
> On Tue, May 24, 2016 at 3:24 AM, Jiri Kosina <jikos@kernel.org> wrote:
>
>> On Thu, 19 May 2016, Fu, Zhonghui wrote:
>>
>>> i2c-hid devices' suspend/resume are usually time-consuming process.
>>> For example, the touch controller(i2c-ATML1000:00) on ASUS T100 tablet
>>> takes about 160ms for suspending and 120ms for resuming. This patch
>>> enables i2c-hid devices to suspend/resume asynchronously. This will
>>> take advantage of multicore and speed up system suspend/resume process.
>> Umm, why do we need this in the first place, given the fact that we are
>> enabling async suspend for each and every HID device allocated via
>> hid_allocate_device() already?
>>
> i2c-hid is not a HID but I2C device on I2C bus and is currently resumed
> synchronously, in-line. Since it tries to reset device as part of resume it
> may take a while for the device to respond.
Sorry for late reply.
Yes, the devices driven by i2c-hid driver are I2C devices, not HID devices.
>
> BTW, I am not quite sure what async suspend enabled
> in hid_allocate_device() does for us, given that I do not see HID bus
> implementing the suspend/resume support for its devices (as far as I
> remember we rely on underlying transports - USB or I2C - to resume the
> devices properly).
Even if HID bus does not implement the suspend/resume support for its devices, the power domain, device type, device class or device driver subsystem related to HID devices can still implement the suspend/resume support for HID devices.


Thanks,
Zhonghui
>
> Thanks,
> Dmitry
>
