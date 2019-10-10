From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/2] HID: google: Detect base folded usage instead of
 hard-coding whiskers
Date: Thu, 10 Oct 2019 21:11:58 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1910102111410.13160@cbobk.fhfr.pm>
References: <20191003031800.120237-1-drinkcat@chromium.org> <20191003031800.120237-2-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003031800.120237-2-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dtor@chromium.org, ikjn@chromium.org
List-Id: linux-input@vger.kernel.org

On Thu, 3 Oct 2019, Nicolas Boichat wrote:

> Some other hammer-like device will emit a similar code, let's look for
> the folded event in HID usage table, instead of hard-coding whiskers
> in many places.

Applied to for-5.5/whiskers. Thanks,

-- 
Jiri Kosina
SUSE Labs
