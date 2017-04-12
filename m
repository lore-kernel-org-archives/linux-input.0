From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: asus: support backlight on USB keyboards
Date: Wed, 12 Apr 2017 22:32:23 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1704122231520.28004@cbobk.fhfr.pm>
References: <20170406101817.14699-1-carlo@caione.org> <20170410063907.GA20349@mail.corp.redhat.com> <CAL9uMOFYk5ru3P96xVTyH_ayq6jiOhn7E1wXLH-BsahYtXP2JA@mail.gmail.com> <alpine.LSU.2.20.1704122211390.28004@cbobk.fhfr.pm>
 <CAL9uMOGfHPiHihFXAYvLU06Jcd9hRQwQve2b=XsLOzHavTBhOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL9uMOGfHPiHihFXAYvLU06Jcd9hRQwQve2b=XsLOzHavTBhOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Carlo Caione <carlo@caione.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Wed, 12 Apr 2017, Carlo Caione wrote:

> > I'll drop the cancel_work_sync() call while doing it, ok?
> 
> Sure, go for it.

Applied to hid.git#for-4.12/asus. Thanks,

-- 
Jiri Kosina
SUSE Labs
