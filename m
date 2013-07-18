From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 7/8] HID: add transport driver documentation
Date: Thu, 18 Jul 2013 10:16:52 +0200
Message-ID: <CAN+gG=Eok6tGT8rAs_J=WCPJTN6W0gb22reMUxHrOmXEMB7kuw@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-8-git-send-email-dh.herrmann@gmail.com>
	<51E52152.3020801@gmail.com>
	<CANq1E4QunK-jykBRCft-GRd=d25Y66bchKiefUqFocR0OyW4yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:45728 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab3GRIQy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jul 2013 04:16:54 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so2203409lab.8
        for <linux-input@vger.kernel.org>; Thu, 18 Jul 2013 01:16:52 -0700 (PDT)
In-Reply-To: <CANq1E4QunK-jykBRCft-GRd=d25Y66bchKiefUqFocR0OyW4yQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

Hi,

On Wed, Jul 17, 2013 at 5:05 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
[snipped]
>>> +
>>> +1) HID Bus
>>> +==========
>>> +
>>> +The HID subsystem is designed as a bus. Any I/O subsystem may provide HID
>>> +devices and register them with the HID bus. HID core then loads generic device
>>> +drivers on top of it. The transport drivers are responsible of raw data
>>> +transport and device setup/management. HID core is responsible of
>>> +report-parsing, report interpretation and the user-space API. Device specifics
>>> +and quirks are also handled by HID core and the HID device drivers.
>>
>> Hmm, the quirks part is not exactly what is currently implemented.
>> Usbhid (Transport Driver) set and use quirks while you say here that
>> they are handled by hid-core.
>>
>> I personally prefer the way it is documented here (quirks handled in
>> hid-core) so HIDP, i2c-hid and uhid will benefit from the dynamic quirks
>> already implemented in usbhid. But that will require another patch :)
>
> I actually meant things like wrong report-descriptors or special
> device drivers. Of course, there are also quirks that apply to the
> transport driver layer. I will rephrase that.

Thanks

>
[snipped]
>> To sum up, I think the differences between the channels are:
>> - Interrupt Channel (intr): asynchronous, device initiated, no
>> acknowledgements (beside the fact that data has been read), read only.
>> - Control Channel (ctrl): synchronous, host initiated, acknowledged
>> (because synchronous), read/write
>> - Output Channel (out): synchronous, host initiated, acknowledged
>> (because synchronous), write only
>
> I intetionally described the channels as "bi-directional". So you
> actually describe the same scenario, but from a different view-point
> (mine obviously is HIDP). So if you consider the OUT channel to be the
> same as writing on INTR, you will get the same scenario. I am not
> entirely sure which is better, but I can change it to your description
> if it helps?

Ok, no all this makes sense to me. FYI the USBHID stack has also 2
separate channels for intr. One Interrupt request and one URB for
writing out Intr. So mixing the two Intr lines into one seems specific
to BT. Anyway, I think you should rephrase it to make it more obvious
that these are not channels, but channel _types_. The Control channel
(type) is a general purposes channel used to send punctual queries to
the device (so it has a head over), whereas the intr channel type is a
dedicated line (half duplex or full duplex) in which each side (host
or device) knows what to do with each packet. Of course, your English
is far better than mine, so feel free to write whatever you want :)

>
> Regarding asynchronous vs. synchronous: I actually don't care how the
> I/O layer implements it. In this document, "asynchronous" means that I
> don't care for any acknowledgements. "synchronous" means, the remote
> device acknowledges the receival. Obviously, if an I/O system always
> acknowledges a SENT, then a transport driver can implement
> asynchronous transports as synchronous transports (which might mean
> having a separate buffer like USBHID does). But HID-core does not
> care.
> Same situation if synchronous is not supported. HID-core assumes it is
> synchronous so the transport layer can simply fake an acknowledgement.
> However, this means that the transport-layer might have to take care
> of retransmissions if an asynchronous transport fails (which L2CAP in
> Bluetooth-Core does tranparently for HIDP).
>
> I will try to be more verbose, but I intentionally posted all the
> callbacks below which should explain that "asynchronous" means it can
> be called in atomic-context and "synchronous" means it is allowed to
> sleep and wait for acknowledgement (speaking of code).

Thanks for the explanation of synchronous vs asynchronous. I was
indeed basing the (a)synchronous thing on the implementation of the
transport layer. So yes, keep your version.

>
> Thanks a lot for the I2C explanation, I think I understand it now and
> it does resemble USBHID and HIDP very much!
>
>> Then, the usbhid transport layer makes the ctrl and out channels
>> asynchronous...
>>
>>> +
>>> +Communication between devices and HID core is mostly done via HID reports. A
>>> +report can be of one of three types:
>>> +
>>> + - INPUT Report: Input reports provide data from device to host. This
>>> +   data may include button events, axis events, battery status or more. This
>>> +   data is generated by the device and sent to the host without requiring
>>
>> _with_ or without requiring explicit requests.
>> On I2C, the command GET_REPORT is even mandatory (which does not seems
>> to be the case for USB, given the amount of QUIRK_NO_INIT_REPORT we have.)
>
> You're right, they can be sent synchronously via GET_REPORT, too.
>
> But I don't know what you mean that GET_REPORT is mandatory? I thought
> an I2C device sends the data and fires an IRQ? Or is, upon interrupt
> receival, the host required to send a GET_REPORT to receive the
> pending input-event? I sadly have no idea how I2C works, but if it is
> _only_ host initiated, then this makes sense. Just want to go sure.

Indeed, when a device sends the data, it fires an IRQ. Then, the host
reads the INPUT register and fetch the data (no head over).
GET_REPORT is used when some driver wants to retrieve the current
state of the report without waiting for the data to be spontaneously
sent. It is mostly used at the start of the driver (or the
application).

I think Microsoft made this request mandatory because so many HID USB
devices are simply blocked when the host calls a GET_REPORT. This way,
we know for sure that the GET_REPORT command will not block the device
because it may be often used. On top of that, it is the only way to
retrieve the FEATURE reports...

[snipped]
>>> +   reports are never sent on the intr channel as this channel is asynchronous.
>>> +
>>> +INPUT and OUTPUT reports can be sent as pure data reports on the intr channel.
>>
>> In my mind, OUTPUT reports are not sent through the intr channel
>> (because write only), but you already get my point I think :)
>
> Yeah, as explained above I merged INTR and OUTPUT into a bi-directional channel.

Ok. Now it makes sense.

>
>>> +For INPUT reports this is the usual operational mode. But for OUTPUT reports,
>>> +this is rarely done as OUTPUT reports are normally quite rare. But devices are
>>> +free to make excessive use of asynchronous OUTPUT reports (for instance, custom
>>> +HID audio speakers make great use of it).
>>
>> Ok, did not know about it.
>>
>>> +
>>> +Raw reports must not be sent on the ctrl channel, though. Instead, the ctrl
>>> +channel provides synchronous GET/SET_REPORT requests.
>>> +
>>> + - GET_REPORT: A GET_REPORT request has a report ID as payload and is sent
>>> +   from host to device. The device must answer with a data report for the
>>> +   requested report ID on the ctrl channel as a synchronous acknowledgement.
>>
>> Beware that the report ID is not mandatory in case the HID report
>> descriptors declares only 1 report without report ID. But I'm fine with
>> it anyway (it's understandable that way).
>
> Ugh, I am not entirely sure but afaik HIDP doesn't support implicit
> IDs. Could you tell me whether I2C supports it?
>
> A report-descriptor can skip report IDs if there is only a single
> report? Didn't know that, but we definitely need to document it.

Actually, this was a "feature" from the USB specification. But it is
up to the hardware maker to decide if it will implement it that way or
not (because it will influence the INPUT report themselves). I2C only
inherited it (so yes, it does support it). However, I never saw a
device not using the report ID...

>
>>> +   Only one GET_REPORT request can be pending for each device. This restriction
>>> +   is enforced by HID core as several transport drivers don't allow multiple
>>> +   simultaneous GET_REPORT requests.
>>> +   Note that data reports which are sent as answer to a GET_REPORT request are
>>> +   not handled as generic device events. That is, if a device does not operate
>>> +   in continuous data reporting mode, an answer to GET_REPORT does not replace
>>> +   the raw data report on the intr channel on state change.
>>> +   GET_REPORT is only used by custom HID device drivers to query device state.
>>> +   Normally, HID core caches any device state so this request is not necessary
>>> +   on devices that follow the HID specs.
>>
>> FYI, HID/I2C spec says: "GET_REPORT is often used by applications on
>> startup to retrieve the ``current state'' of the device rather than
>> waiting for the device to generate the next input/feature report".
>
> Yeah, for startup this makes sense. I will add a short note.
>
>> And as under Linux applications do not talk directly to the hid devices,
>> I fully concurs to your point.
>>
>>> +   GET_REPORT requests can be sent for any of the 3 report types and shall
>>> +   return the current report state of the device.
>>
>> The HID/I2C spec explicitly says: "the DEVICE shall ignore a GET_REPORT
>> requests with the REPORT TYPE set to Output, as it is not used in this
>> specification." So under i2c, we can send GET_REPORT with OUTPUT, but we
>> will not get anything from the device (this is why it is forbidden by
>> the transport driver).
>
> Heh, didn't know that, either. It's fine if I2C ignores it. However,
> I'd like to avoid forbidding it. There can be devices which use this
> (companies to crazy things..) and I cannot see a reason to forbid it
> in HID core. The transport drivers are free to adhere to their
> specifications, though. I guess that's fine?

perfectly fine :)

>
>>> + - SET_REPORT: A SET_REPORT request has a report ID plus data as payload. It is
>>> +   sent from host to device and a device must update it's current report state
>>> +   according to the given data. Any of the 3 report types can be used.
>>
>> The HID/I2C spec explicitly says: "the DEVICE might choose to ignore
>> input SET_REPORT requests as meaningless."...
>
> Same as above I think. But thanks for the clarification! I guess I
> will add a note that it is discouraged and devices are not supposed to
> handle it. This should clear all doubts.

Beware that devices should not use SET_REPORT for _input_ reports. But
still, in the end, it is up to the manufacturer of the device to
define it's own protocol. So I think I will need to change I2C to not
prevent SET_REPORT on INPUT reports, or GET_REPORT on OUTPUT reports
because I am sure one company will decide to use it that way to
initialize their device...

>
>>> +   A device must answer with a synchronous acknowledgement. However, HID core
>>> +   does not require transport drivers to forward this acknowledgement to HID
>>> +   core.
>>> +   Same as for GET_REPORT, only one SET_REPORT can be pending at a time. This
>>> +   restriction is enforced by HID core as some transport drivers do not support
>>> +   multiple synchronous SET_REPORT requests.
>>> +
>>> +Other ctrl-channel requests are supported by USB-HID but are not available
>>> +(or deprecated) in most other transport level specifications:
>>> +
>>> + - GET/SET_IDLE: Only used by USB-HID. Do not implement!
>>> + - GET/SET_PROTOCOL: Not used by HID core. Do not implement!
>>
>> The I2C declares also:
>> - RESET: mandatory (reset the device at any time)
>> - SET_POWER: mandatory on the device side (request from host to device
>> to indicate preferred power setting).
>
> Are they hooked up to HID-core? I'd like to avoid any commands which

No they are not. Actually I double checked with the USB spec, and it
is indeed specific to the I2C spec...

> are handled transparently in the transport driver (like
> suspend/resume). However, SET_POWER sounds related to ->power()
> callback. I will look through it again and include it in the next
> revision if it is hooked up.

I would say don't bother with the two of them. I thought they were
more generic but as they are specific to I2C, it does not make sense
to include them in this documentation. And you are right, SET_POWER
should be handled through ->power().
Also I need to remind you that the I2C implementation is not widely
tested because they are so few devices including it. This should
change in the near future (the power consumption is very low compared
to USB, so I expect OEM will start integrating them), but actually, I
still didn't got my hand on a real consumer product with HID/I2C... So
adjustments are expected to come, but the basic features are here, so
that people will not complain of not having a
touchpad/keyboard/touchscreen not working... :)

>
>>> +
>>> +2) HID API
>>> +==========
>>> +
>>> +2.1) Initialization
>>> +-------------------
>>> +
>>> +Transport drivers normally use the following procedure to register a new device
>>> +with HID core:
>>> +
>>> +       struct hid_device *hid;
>>> +       int ret;
>>> +
>>> +       hid = hid_allocate_device();
>>> +       if (IS_ERR(hid)) {
>>> +               ret = PTR_ERR(hid);
>>> +               goto err_<...>;
>>> +       }
>>> +
>>> +       strlcpy(hid->name, <device-name-src>, 127);
>>> +       strlcpy(hid->phys, <device-phys-src>, 63);
>>> +       strlcpy(hid->uniq, <device-uniq-src>, 63);
>>> +
>>> +       hid->ll_driver = &custom_ll_driver;
>>> +       hid->bus = <device-bus>;
>>> +       hid->vendor = <device-vendor>;
>>> +       hid->product = <device-product>;
>>> +       hid->version = <device-version>;
>>> +       hid->country = <device-country>;
>>
>> FYI, HID/I2C does not define any device-country field (I guess it will
>> come in a later release...)
>
> Right, I think BT also sets it to 0 in bluez. I will add a note that
> "0" is the default value.
>
>>> +       hid->dev.parent = <pointer-to-parent-device>;
>>
>> FYI, I have started implementing a devm API for HID (in the same way the
>> input devm API is implemented), and dev.parent should not be overwritten.
>
> Cool! I will adjust the document once it is merged.
>
>> Anyway the two last comments are not requesting any changes in the document.
>>
>>> +       hid->driver_data = <transport-driver-data-field>;
>>> +
>>> +       ret = hid_add_device(hid);
>>> +       if (ret)
>>> +               goto err_<...>;
>>> +
>>> +Once hid_add_device() is entered, HID core might use the callbacks provided in
>>> +"custom_ll_driver". To unregister a device, use:
>>                     ^^^^
>> Maybe introduce a new paragraph (otherwise, it looks like
>> hid_destroy_device is called from HID core).
>
> Indeed, will do that.
>
>>> +
>>> +       hid_destroy_device(hid);
>>> +
>>> +Once hid_destroy_device() returns, HID core will no longer make use of any
>>> +driver callbacks.
>>> +
>>> +2.2) hid_ll_driver operations
>>> +-----------------------------
>>> +
>>> +The available HID callbacks are:
>>> + - int (*start) (struct hid_device *hdev)
>>> +   Called from HID device drivers once they want to use the device. Transport
>>> +   drivers can choose to setup their device in this callback. However, normally
>>> +   devices are already set up before transport drivers register them to HID core
>>> +   so this is mostly only used by USB-HID.
>>> +
>>> + - void (*stop) (struct hid_device *hdev)
>>> +   Called from HID device drivers once they are done with a device. Transport
>>> +   drivers can free any buffers and deinitialize the device. But note that
>>> +   ->start() might be called again if another HID device driver is loaded on the
>>> +   device.
>>> +   Transport drivers are free to ignore it and deinitialize devices after they
>>> +   destroyed them via hid_destroy_device().
>>> +
>>> + - int (*open) (struct hid_device *hdev)
>>> +   Called from HID device drivers once they are interested in data reports.
>>> +   Usually, while user-space didn't open any input API/etc., device drivers are
>>> +   not interested in device data and transport drivers can put devices asleep.
>>> +   However, once ->open() is called, transport drivers must be ready for I/O.
>>> +   ->open() calls are never nested. So in between two ->open() calls there must
>>> +   be a call to ->close().
>>
>> This is not true in either USB or I2C. And I guess with every BT or UHID
>> devices. ->open() and ->close() are called upon open/close of the input
>> node (or hidraw, or hiddev). So If two clients are opening the same
>> input node, there will be two calls to ->open() without any call to
>> ->close() in between.
>>
>> I guess you mixed up this part with the ->start() ->stop() :)
>
> I got confused, indeed. input-core only calls ->open() on first-open,
> but there might be multiple input devices. So you're right. I will fix
> this. Thanks for catching it!
>
>>> +
>>> + - void (*close) (struct hid_device *hdev)
>>> +   Called from HID device drivers after ->open() was called but they are no
>>> +   longer interested in device reports. (Usually if user-space closed any input
>>> +   devices of the driver).
>>> +   Transport drivers can put devices asleep and terminate any I/O. However,
>>> +   ->start() may be called again if the device driver is interested in input
>>> +   reports again.
>>> +
>>> + - int (*parse) (struct hid_device *hdev)
>>> +   Called once during device setup after ->start() has been called. Transport
>>> +   drivers must read the HID report-descriptor from the device and tell HID core
>>> +   about it via hid_parse_report().
>>> +
>>> + - int (*power) (struct hid_device *hdev, int level)
>>> +   Called by HID core to give PM hints to transport drivers. Usually this is
>>> +   analogical to the ->open() and ->close() hints and redundant.
>>> +
>>> + - void (*request) (struct hid_device *hdev, struct hid_report *report,
>>> +                    int reqtype)
>>> +   Send an HID request on the ctrl channel. "report" contains the report that
>>> +   should be sent and "reqtype" the request type. Request-type can be
>>> +   HID_REQ_SET_REPORT or HID_REQ_GET_REPORT.
>>> +   This callback is optional. If not provided, HID core will assemble a raw
>>> +   report following the HID specs and send it via the ->raw_request() callback.
>>> +   The transport driver is free to implement this asynchronously.
>>> +
>>> + - int (*wait) (struct hid_device *hdev)
>>> +   Used by HID core before calling ->request() again. A transport driver can use
>>> +   it to wait for any pending requests to complete if only one request is
>>> +   allowed at a time.
>>> +
>>> + - int (*raw_request) (struct hid_device *hdev, unsigned char reportnum,
>>> +                       __u8 *buf, size_t count, unsigned char rtype,
>>> +                       int reqtype)
>>> +   Same as ->request() but provides the report as raw buffer. This request shall
>>> +   be synchronous. A transport driver must not use ->wait() to complete such
>>> +   requests.
>>
>> 2 questions/remarks here:
>> - is raw_request() meant to replace ->hid_output_raw_report() and
>> ->hid_get_raw_report()?
>
> Both. raw_request() with HID_REQ_GET_REPORT replaces
> hid_get_raw_report() and with HID_REQ_SET_REPORT it replaces
> hid_output_raw_report().
> However, at least HIDP implements hid_output_raw_report() with
> HID_OUTPUT_REPORT as raw output report instead of SET_REPORT. For
> this, "output_report()" below can be used.

thanks. I definitively prefers this. The fact is that USB is very
tolerant and can rely on the USB descriptor to know if it needs to use
SET_REPORT or OUTPUT_REPORT. I tried to implement the same kind of
thing in I2C, but I am not very happy with the final implementation.
So definitively having an explicit way to handle this will allow us to
write specific drivers in case there is some troubles with the
automatic handling.

>
>> - reportnum declared as an unsigned will be problematic regarding the
>> rare devices not having any report ID in their report descriptors.
>
> I thought reportnum 0 is an invalid ID? I will check again and change
> to signed if needed. Thanks!

You are right. reportnum == 0 is treated in the USBHID stack as a
report without a report ID. So keeping the unsigned is good here.

>
>>> +
>>> + - int (*output_report) (struct hid_device *hdev, __u8 *buf, size_t len)
>>> +   Send raw output report via intr channel. Used by some HID device drivers
>>> +   which require high throughput for outgoing requests on the intr channel. This
>>> +   must not cause SET_REPORT calls! This must be implemented as asynchronous
>>> +   output report on the intr channel!
>>
>> For me, there is something wrong here. The name infers that we are
>> trying to send an output_report directly (so through the USB URB or
>> through the output i2c register), but you are implementing it through
>> the intr channel... :-S
>
> Again, "write on INTR" is OUTPUT channel for me. So I guess with the
> explanation above we are fine here?

sure, now it's clear.

>
>>> +
>>> + - int (*hidinput_input_event) (struct input_dev *idev, unsigned int type,
>>> +                                unsigned int code, int value)
>>> +   Obsolete callback used by logitech converters. It is called when userspace
>>> +   writes input events to the input device (eg., EV_LED). A driver can use this
>>> +   callback to convert it into an output report and send it to the device. If
>>> +   this callback is not provided, HID core will use ->request() or
>>> +   ->raw_request() respectively.
>>
>> I bet there will be a way to make this work with logitech devices too
>> (if we implement a proper ->hid_output_raw_report() in each paired devices).
>
> Yeah, I thought so, but I have no idea what the logitech-dj driver
> does. I guess we can drop this once we have no more users, but I
> wanted to avoid pushing to hard on it.

Well, I know it well because I helped Logitech pushing hid-logitech-dj
upstream. Don't bother with it currently, we will remove this part
from the documentation once all the drivers are converted.

>
>>> +
>>> + - int (*idle) (struct hid_device *hdev, int report, int idle, int reqtype)
>>> +   Perform SET/GET_IDLE request. Only used by USB-HID, do not implement!
>>> +
>>> +2.3) Data Path
>>> +--------------
>>> +
>>> +Transport drivers are responsible of reading data from I/O devices. They must
>>> +handle any state-tracking themselves. HID core does not implement protocol
>>
>> I don't get the "state-tracking" here. The reports states should be
>> handled by core, and I do not see the other states (or you meant PM
>> states?).
>
> Ugh, I meant I/O-related state-tracking (or PM). I will rephrase that.

Thanks

>
>>> +handshakes or other management commands which can be required by the given HID
>>> +transport specification.
>>> +
>>> +Every raw data packet read from a device must be fed into HID core via
>>> +hid_input_report(). You must specify the channel-type (intr or ctrl) and report
>>> +type (input/output/feature). Under normal conditions, only input reports are
>>> +provided via this API.
>>> +
>>> +Responses to GET_REPORT requests via ->request() must also be provided via this
>>> +API. Responses to ->raw_request() are synchronous and must be intercepted by the
>>> +transport driver and not passed to hid_input_report().
>>> +Acknowledgements to SET_REPORT requests are not of interest to HID core.
>>> +
>>> +----------------------------------------------------
>>> +Written 2013, David Herrmann <dh.herrmann@gmail.com>
>>> --
>>> 1.8.3.2
>>>
>>
>> done!
>> Many thanks for this David. It was very interesting and detailed. It
>> will make a great documentation.
>
> Thanks a lot for reviewing. I will fix the remaining issues and with
> the "write-on-INTR is OUTPUT" I guess we are on the same page (except
> for minor issues)?
>

Yep, we are on the same page. Once you will have sent the v2, Jiri
will have a look on it and I think we will be good :)

Cheers,
Benjamin
