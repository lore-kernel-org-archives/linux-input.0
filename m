From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: Make sure the HID device is opened on resume
Date: Fri, 8 Sep 2017 15:01:59 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709081501330.3285@jbgna.fhfr.qr>
References: <20170723011509.23651-1-lyude@redhat.com> <20170724081529.GA18097@mail.corp.redhat.com> <1500918561.6243.3.camel@redhat.com> <20170908071612.GB1426@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170908071612.GB1426@mail.corp.redhat.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, linux-input@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 8 Sep 2017, Benjamin Tissoires wrote:

> I know I requested a v2, but meanwhile some users are experiencing
> delays at resume:
> https://bugzilla.kernel.org/show_bug.cgi?id=196851
> 
> Jiri, could you take this one in v4.14 (maybe with @stable) and we'll
> figure out a way to fix this properly later (looks like the .resume and
> .reset_resume are called from the transport drivers, not hid-core, so we
> might need a little bit of testing).
> 
> In its current form (with the nitpick Andy noticed):
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Ok, makes sense. Now applied to for-4.14/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
