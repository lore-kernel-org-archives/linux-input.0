From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/1] HID: logitech: read all 32 bits of report type
 bitfield
Date: Fri, 11 May 2012 19:44:10 -0500
Message-ID: <20120512004410.GB2931@burratino>
References: <1336745836-17385-1-git-send-email-nlopezcasad@logitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1336745836-17385-1-git-send-email-nlopezcasad@logitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, hugo@osvaldobarrera.com.ar, 671292@bugs.debian.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Nestor Lopez Casado wrote:

> From: Jonathan Nieder <jrnieder@gmail.com>
>
> On big-endian systems (e.g., Apple PowerBook), trying to use a
> logitech wireless mouse with the Logitech Unifying Receiver does not
> work with v3.2 and later kernels.  The device doesn't show up in
> /dev/input.  Older kernels work fine.
>
> That is because the new hid-logitech-dj driver claims the device.  The
> device arrival notification appears:
>
>	20 00 41 02 00 00 00 00 00 00 00 00 00 00 00
>
> and we read the report_types bitfield (02 00 00 00) to find out what
> kind of device it is.  Unfortunately the driver only reads the first 8
> bits and treats that value as a 32-bit little-endian number, so on a
> powerpc the report type seems to be 0x02000000 and is not recognized.

Sigh, I took the wrong line in this example.  The above event is
"device list empty" and report_types is 0 as you'd expect.  The
example I meant to use:

		20 01 41 01 1a 10 04 00 00 00 00 00 00 00 00

	and we read the report_types bitfield (04 00 00 00) to find out what
	kind of device it is.  Unfortunately the driver only reads the first 8
	bits and treats that value as a 32-bit little-endian number, so on a
	powerpc the report type seems to be 0x04000000 and is not recognized.

Jiri, please amend the message if convenient, or I'm fine with leaving
it be if not.  Sorry for the nonsense.
