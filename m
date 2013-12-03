From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: logitech-dj: add HIDRAW dependency in Kconfig
Date: Tue, 3 Dec 2013 15:08:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312031507260.24931@pobox.suse.cz>
References: <1386026244-21553-1-git-send-email-ogay@logitech.com> <alpine.LNX.2.00.1312030852410.24931@pobox.suse.cz> <CAFLMSp-7X568ZdZ-JAAX9ttmMFhYP+DeLuc_-yCw1WCuvVAHng@mail.gmail.com> <alpine.LNX.2.00.1312031350130.24931@pobox.suse.cz>
 <CAE7qMrq6YzvprAGDTO8uEU9WZXXGpP=TG_OxB6=-1KuF1Tr8sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE7qMrq6YzvprAGDTO8uEU9WZXXGpP=TG_OxB6=-1KuF1Tr8sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Olivier Gay <ogay@logitech.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mathieu Meisser <mmeisser@logitech.com>
List-Id: linux-input@vger.kernel.org

On Tue, 3 Dec 2013, Nestor Lopez Casado wrote:

> > > <3>[  210.131988] logitech-djreceiver 0003:046D:C52B.0005: claimed by
> > > neither input, hiddev nor hidraw
> > > <3>[  210.132202] logitech-djreceiver 0003:046D:C52B.0005:
> > > logi_dj_probe:hid_hw_start returned error
> > >
> > > In logi_dj_probe, we call hid_hw_start with HID_CONNECT_DEFAULT
> > > argument and if hidraw driver is not present, the call fails and we
> > > return an error in logi_dj_probe.
> > >
> > > > It's clear that without hidraw it's not possible to change the pairing
> > > > from userspace, but I fail to see why probing the receiver should be
> > > > affected?
> > >
> > > As of today, hid-logitech-dj.c depends on hidraw API to work. All HID
> > > reports sent to control / configure the receiver are sent using hidraw
> > > API. That's why we fail logi_dj_probe if we cannot connect to hidraw.
> >
> > Hmm, so unifying receiver is not claimed by hid-input at all?
> > (HID_CONNECT_DEFAULT also contains HID_CONNECT_HIDINPUT) How so?
> >
> > (again, I will not be able to test it with my receiver up until the day
> > after tomorrow).
> >
> The unifying receiver has 3 usb interfaces. When hid-logitech-dj driver is
> loaded, interfaces 0 and 1 are discarded.
> 
> Interface 2 consists of a hid class interface with 3 collections, each of
> which sports the 'vendor' usage, thus, there is no reason for hid_input to
> claim any of them. On the other hand, hidraw has no issue in claiming the
> collections, even if they are 'vendor'. As of today, hid-logitech-dj uses
> hidraw api to send configuration/control reports to interface 2 of the
> Unifying receiver.
> 
> Without the hid-logitech-dj driver, interfaces 0 and 1 are claimed by
> hid-input, as they correspond to a keyboard and a mouse. But that is not
> relevant to the discussion.

Ah, indeed, that's the part I forgot and will find out only when I have my 
receiver handy again.

Thanks for the explanation, now it all makes sense. I will be queuing the 
patch, with probably slightly more verbose changelog.

-- 
Jiri Kosina
SUSE Labs
