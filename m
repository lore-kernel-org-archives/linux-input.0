From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 2/2] HID: input: do not increment usages when a
 duplicate is found
Date: Tue, 17 Apr 2018 14:11:00 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804171410360.28129@cbobk.fhfr.pm>
References: <20171208142818.15156-1-benjamin.tissoires@redhat.com> <20171208142818.15156-3-benjamin.tissoires@redhat.com> <20171210222926.GB11027@jelly> <20180416235156.GE77055@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416235156.GE77055@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 16 Apr 2018, Dmitry Torokhov wrote:

> So what is happening with this series? I think we should get it them
> in; there is really no reason for bumping ABS_MISC till it gets into
> ABS_MT_* range on some devices that are out there.
> 
> FWIW
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Sorry, I somehow lost this one. Now queued for 4.18.

Thanks,

-- 
Jiri Kosina
SUSE Labs
