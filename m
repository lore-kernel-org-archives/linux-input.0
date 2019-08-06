From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Fix race condition between rumble and device
 remove.
Date: Tue, 6 Aug 2019 12:46:47 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1908061246320.27147@cbobk.fhfr.pm>
References: <20190802225019.2418-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190802225019.2418-1-roderick@gaikai.com>
Sender: stable-owner@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, svv@google.com, pgriffais@valvesoftware.com, Roderick Colenbrander <roderick.colenbrander@sony.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2 Aug 2019, Roderick Colenbrander wrote:

> Valve reported a kernel crash on Ubuntu 18.04 when disconnecting a DS4
> gamepad while rumble is enabled. This issue is reproducible with a
> frequency of 1 in 3 times in the game Borderlands 2 when using an
> automatic weapon, which triggers many rumble operations.
> 
> We found the issue to be a race condition between sony_remove and the
> final device destruction by the HID / input system. The problem was
> that sony_remove didn't clean some of its work_item state in
> "struct sony_sc". After sony_remove work, the corresponding evdev
> node was around for sufficient time for applications to still queue
> rumble work after "sony_remove".
> 
> On pre-4.19 kernels the race condition caused a kernel crash due to a
> NULL-pointer dereference as "sc->output_report_dmabuf" got freed during
> sony_remove. On newer kernels this crash doesn't happen due the buffer
> now being allocated using devm_kzalloc. However we can still queue work,
> while the driver is an undefined state.
> 
> This patch fixes the described problem, by guarding the work_item
> "state_worker" with an initialized variable, which we are setting back
> to 0 on cleanup.

Applied to for-5.3/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
