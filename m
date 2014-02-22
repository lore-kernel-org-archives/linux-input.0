From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Mixed HID descriptors
Date: Sat, 22 Feb 2014 18:04:41 +0100
Message-ID: <CANq1E4TvqF0cXDF8U6ofg-E81O77v3fxN1JC8=gJZzSUBCjRmQ@mail.gmail.com>
References: <5305E327.2020504@displax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:62456 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaBVREl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Feb 2014 12:04:41 -0500
Received: by mail-ie0-f180.google.com with SMTP id ar20so2269373iec.39
        for <linux-input@vger.kernel.org>; Sat, 22 Feb 2014 09:04:41 -0800 (PST)
In-Reply-To: <5305E327.2020504@displax.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@displax.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

Hi

CC Jiri, Benjamin and Henrik

On Thu, Feb 20, 2014 at 12:12 PM, Nuno Santos <nsantos@displax.com> wrote:
> Hi,
>
> We are developing an HID multitouch device and we want to make it fully
> compatible with Linux and Windows.
>
> The device descriptor describes a mouse, keyboard and multitouch digitizer
> as well as a set of features. When we have mouse or keyboard descriptor
> along the touch device I can no longer get or set features. It gives me a
> timeout error:
>
> ioctl (GFEATURE): Connection timed out
>
> This only happens in Linux.
>
> I would like to know if this is normal, or if there is anyway of getting
> more information about the parsing itself in order to understand the
> problem.
>
> Below is the device report descriptor

I don't have much time to test it myself, but you can get a lot of
debug information via debugfs. Most distros enable it by default. Try
looking into /sys/kernel/debug/hid/<dev>/
These debugfs files contain runtime information about HID internals.

Thanks
David

> __ALIGN_BEGIN
> static uint8_t HID_ReportDesc[]
> __ALIGN_END =
> {
>     #if 0 // IS MESSING HID ON LINUX
>     0x05, 0x01,                            // Usage Page (Generic Desktop)
>     0x09, 0x06,                            // Usage (Keyboard)
>     0xA1, 0x01,                            // Collection (Application)
>     0x85, REPORTID_KEYBOARD,               //   REPORT_ID (Mouse)
>     0x05, 0x07,                            //   Usage page (Key Codes)
>     0x19, 0xE0,                            //   Usage minimum (224)
>     0x29, 0xE7,                            //   Usage maximum (231)
>     0x15, 0x00,                            //   Logical minimum (0)
>     0x25, 0x01,                            //   Logical maximum (1)
>     0x75, 0x01,                            //   Report size (1)
>     0x95, 0x08,                            //   Report count (8)
>     0x81, 0x02,                            //   Input (data, variable,
> absolute)
>     0x95, 0x01,                            //   Report count (1)
>     0x75, 0x08,                            //   Report size (8)
>     0x81, 0x01,                            //   Input (constant)
>     0x95, 0x06,                            //   Report count (6)
>     0x75, 0x08,                            //   Report size (8)
>     0x15, 0x00,                            //   Logical minimum (0)
>     0x25, 0x65,                            //   Logical maximum (101)
>     0x05, 0x07,                            //   Usage page (key codes)
>     0x19, 0x00,                            //   Usage minimum (0)
>     0x29, 0x65,                            //   Usage maximum (101)
>     0x81, 0x00,                            //   Input (data, array)
>     0xC0,
>     #endif
>
>     #if 0 // IS MESSING HID ON LINUX
>     0x05, 0x01,                         // USAGE_PAGE (Generic Desktop)
>     0x09, 0x01,                         // USAGE (Pointer)
>     0xa1, 0x01,                         // COLLECTION (Application)
>     0x85, REPORTID_MOUSE,               //   REPORT_ID (Mouse)
>     0x09, 0x01,                         //   USAGE (Pointer)
>     0xa1, 0x00,                         //   COLLECTION (Physical)
>     0x05, 0x09,                         //     USAGE_PAGE (Buttons)
>     0x09, 0x01,                         //     USAGE (Button 1)
>     0x95, 0x01,                         //     REPORT_COUNT (1)
>     0x75, 0x01,                         //     REPORT_SIZE (1)
>     0x15, 0x00,                         //     LOGICAL_MINIMUM (0)
>     0x25, 0x01,                         //     LOGICAL_MAXIMUM (1)
>     0x81, 0x02,                         //     INPUT (Data,Var,Abs)
>     0x95, 0x07,                         //     REPORT_COUNT (7)
>     0x75, 0x01,                         //     REPORT_SIZE (1)
>     0x81, 0x03,                         //     INPUT (Const,Var,Abs)
>     0x95, 0x08,                         //     REPORT_COUNT (8)
>     0x75, 0x01,                         //     REPORT_SIZE (1)
>     0x81, 0x03,                         //     INPUT (Const,Var,Abs)
>     0x05, 0x01,                         //     USAGE_PAGE (Generic Desktop)
>     0x09, 0x30,                         //     USAGE (X)
>     0x09, 0x31,                         //     USAGE (Y)
>     0x15, 0x00,                         //     LOGICAL_MINIMUM (0)
>     0x26, 0xff, 0x7f,                   //     LOGICAL_MAXIMUM (32767)
>     0x35, 0x00,                         //     PHYSICAL_MINIMUM (0)
>     0x46, 0x00, 0x00,                   //     PHYSICAL_MAXIMUM (0)
>     0x95, 0x02,                         //     REPORT_COUNT (2)
>     0x75, 0x10,                         //     REPORT_SIZE (16)
>     0x81, 0x02,                         //     INPUT (Data,Var,Abs)
>     0xc0,                               //   END_COLLECTION
>     0xa1, 0x02,                         //   COLLECTION (Logical)
>     0x15, 0x00,                         //     LOGICAL_MINIMUM (0)
>     0x26, 0xff, 0x00,                   //     LOGICAL_MAXIMUM (255)
>     0x09, 0x01,                         //     USAGE (Pointer)
>     0x95, 0x39,                         //     REPORT_COUNT (57)
>     0x75, 0x08,                         //     REPORT_SIZE (8)
>     0x81, 0x01,                         //     INPUT (Data,Var,Abs)
>     0xc0,                               //   END_COLLECTION
>     0xc0,                               // END_COLLECTION
>     #endif
>
>     #if 1
>     0x05, 0x0d,                            // USAGE_PAGE (Digitizers)
>     0x09, 0x0E,                         // USAGE (Configuration)
>     0xa1, 0x01,                         // COLLECTION (Application)
>     0x85, REPORTID_MODE,                 //   REPORT_ID (Feature)
>     0x09, 0x23,                         //   USAGE (Device Settings)
>     0xa1, 0x02,                         //   COLLECTION (logical)
>     0x09, 0x52,                         //     USAGE (Device Mode)
>     0x09, 0x53,                         //     USAGE (Device Index)
>     0x15, 0x00,                         //     LOGICAL_MINIMUM (0)
>     0x25, 0x28,                         //     LOGICAL_MAXIMUM (40)
>     0x75, 0x08,                         //     REPORT_SIZE (8)
>     0x95, 0x02,                         //     REPORT_COUNT (2)
>     0xb1, 0x02,                         //     FEATURE (Data,Var,Abs)
>     0xc0,                               //   END_COLLECTION
>     0xc0,                               // END_COLLECTION
>
>     0x09, 0x04,                            // USAGE (Touch Screen)
>     0xa1, 0x01,                         // COLLECTION (Application)
>     0x85, REPORTID_TOUCH,               //      REPORT_ID (Touch)
>     0x09, 0x22,                         //   USAGE (Finger)
>
>     0x05, 0x0d,                         /*     USAGE_PAGE (Digitizers)
> */
>     0xa1, 0x02,                         /*     COLLECTION (Logical)
> */
>     0x09, 0x42,                         /*       USAGE (Tip Switch)
> */
>     0x15, 0x00,                         /*       LOGICAL_MINIMUM (0)
> */
>     0x25, 0x01,                         /*       LOGICAL_MAXIMUM (1)
> */
>     0x75, 0x01,                         /*       REPORT_SIZE (1)
> */
>     0x95, 0x01,                         /*       REPORT_COUNT (1)
> */
>     0x81, 0x02,                         /*       INPUT (Data,Var,Abs)
> */
>     0x09, 0x32,                         /*       USAGE (In Range)
> */
>     0x81, 0x02,                         /*       INPUT (Data,Var,Abs)
> */
>     0x09, 0x47,                         /*       USAGE (Confidence)
> */
>     0x81, 0x02,                         /*       INPUT (Data,Var,Abs)
> */
>     0x95, 0x05,                         /*       REPORT_COUNT (5)
> */
>     0x81, 0x03,                         /*       INPUT (Cnst,Ary,Abs)
> */
>     0x09, 0x51,                         /*       USAGE (Contact Identifier)
> */
>     0x75, 0x08,                         /*       REPORT_SIZE (8)
> */
>     0x95, 0x01,                         /*       REPORT_COUNT (1)
> */
>     0x81, 0x02,                         /*       INPUT (Data,Var,Abs)
> */
>     0xa1, 0x00,                         /*       COLLECTION (Physical)
> */
>     0x05, 0x01,                         /*         USAGE_PAGE (Generic
> Desktop) */
>     0x15, 0x00,                         /*         LOGICAL_MINIMUM (0)
> */
>     0x26, 0x3A, 0x20,                   /*         LOGICAL_MAXIMUM (8200)
> */
>     0x75, 0x10,                         /*         REPORT_SIZE (16)
> */
>     0x09, 0x30,                         /*         USAGE (X)
> */
>     0x81, 0x02,                         /*         INPUT (Data,Var,Abs)
> */
>     0x15, 0x00,                         /*         LOGICAL_MINIMUM (0)
> */
>     0x26, 0x5C, 0x12,                   /*         LOGICAL_MAXIMUM (4700)
> */
>     0x09, 0x31,                         /*         USAGE (Y)
> */
>     0x81, 0x02,                         /*         INPUT (Data,Var,Abs)
> */
>     0x05, 0x0d,                         /*         USAGE_PAGE (Digitizers)
> */
>     0x09, 0x30,                         /*         USAGE (X)
> */
>     0x75, 0x10,                         /*         REPORT_SIZE (16)
> */
>     0x95, 0x01,                         /*         REPORT_COUNT (1)
> */
>     0x81, 0x02,                         /*         INPUT (Data,Var,Abs)
> */
>     0xc0,                               /* END_COLLECTION
> */
>     0xc0,                               /* END_COLLECTION
> */
>
>     0x05, 0x0d,                         //   USAGE_PAGE (Digitizers)
>     0x09, 0x54,                         //   USAGE (Actual count)
>     0x15, 0x00,                         //   LOGICAL_MAXIMUM (0)
>     0x25, 0x14,                         //   LOGICAL_MAXIMUM (20)
>     0x95, 0x01,                         //   REPORT_COUNT (1)
>     0x75, 0x08,                         //   REPORT_SIZE (8)
>     0x81, 0x02,                         //   INPUT (Data,Var,Abs)
>
>     0x85, REPORTID_MAX_COUNT,           //   REPORT_ID (Feature)
>     0x09, 0x55,                         //   USAGE(Maximum Count)
>     0x15, 0x00,                         //   LOGICAL_MINIMUM (0)
>     0x25, 0x14,                         //   LOGICAL_MAXIMUM (20)
>     0x95, 0x01,                         //   REPORT_COUNT (1)
>     0x75, 0x08,                         //   REPORT_SIZE (8)
>     0xb1, 0x02,                         //   FEATURE (Data,Var,Abs)
>     0xc0,                               // END_COLLECTION
>     #endif
>
>     #if 1
>     0x09, 0x00,                            // USAGE (Undefined)
>     0xa1, 0x01,                         // COLLECTION (Application)
>     0x85, REPORTID_ENABLE,              //   REPORT_ID (Feature)
>     0x09, 0x00,                         //   USAGE(Undefined)
>     0x95, 0x01,                         //   REPORT_COUNT (1)
>     0x75, 0x08,                         //   REPORT_SIZE (8)
>     0xb1, 0x02,                         //   FEATURE (Data,Var,Abs)
>     0x85, REPORTID_GAIN,                //   REPORT_ID (Feature)
>     0x09, 0x00,                         //   USAGE(Undefined)
>     0x15, 0x00,                         //   LOGICAL_MINIMUM (0)
>     0x25, 0x07,                         //   LOGICAL_MAXIMUM (7)
>     0x95, 0x01,                         //   REPORT_COUNT (1)
>     0x75, 0x08,                         //   REPORT_SIZE (8)
>     0xb1, 0x02,                         //   FEATURE (Data,Var,Abs)
>     0xc0,                               // END_COLLECTION
>     #endif
> };
>
> With my best regards,
>
> Nuno Santos
> www.displax.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
