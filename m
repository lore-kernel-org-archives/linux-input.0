From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/5] HID: hid-multitouch: get maxcontacts also from
 logical_max value
Date: Thu, 10 May 2012 14:46:42 +0200
Message-ID: <20120510124642.GA9254@polaris.bitmath.org>
References: <1336136030-18503-1-git-send-email-benjamin.tissoires@gmail.com>
 <1336136030-18503-3-git-send-email-benjamin.tissoires@gmail.com>
 <20120506190322.GB12571@polaris.bitmath.org>
 <CAN+gG=HQ_U5dhVvgLu0zfMjv1+SAVB2Rx8fNq8tLX2DUHOMa9A@mail.gmail.com>
 <20120509194623.GA12381@polaris.bitmath.org>
 <CAN+gG=Fyq7S54rkDRsUmEytxcU-HQb68qENnED8=xaUxF3-BXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=Fyq7S54rkDRsUmEytxcU-HQb68qENnED8=xaUxF3-BXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > As long as all existing devices are unaffected, it's fine, hence the question.
> 
> I checked all the reports descriptors that I have.
> 2 devices (one Stantum and one Irtouch) present an unrealistic
> logical_max value (255). The thing is that if this logical_max is
> false, and if the value is not provided, then I don't know how could I
> retrieve the right value beside introducing a MT_CLS...
> 
> Henrik, do you think that 255 is two much for the slots?

It is large enough for us to start worrying about how we manage
memory, not to mention throughput. Since we do not really have devices
of that type yet, how about adding a MT_MAX_MAXCONTACT next to
MT_DEFAULT_MAXCONTACT, and use it as a sanity check, like so:

	if (!td->maxcontacts && field->logical_maximum <= MT_MAX_MAXCONTACT)
		td->maxcontacts = field->logical_maximum;

Then the default (10) would be picked for the suspect devices, just as
it is today.

Thanks,
Henrik
