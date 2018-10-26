From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/3] HID: debug: fix the ring buffer implementation
Date: Fri, 26 Oct 2018 17:25:21 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810261724510.23511@cbobk.fhfr.pm>
References: <20181003171936.11271-1-vdronov@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181003171936.11271-1-vdronov@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladis Dronov <vdronov@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 3 Oct 2018, Vladis Dronov wrote:

> This patchset is fixing some aspects of the ring buffer implementation in
> drivers/hid/hid-debug.c. This implementation has certain problem points:
> 
> - it may stuck in an infinite loop
> - it may return corrupted data
> - a reader and a writer are not protected by spinlocks, which can lead to
>   the corrupted data
> 
> The suggested patchset is a new ring buffer implementation which overwrites
> the oldest data in case of an overflow. One can verify the suggested ring
> buffer implementation by fuzzing it with modified kernel and fuzzer-reader
> at: https://gist.github.com/nefigtut/33d56e3870b67493cc867344aed2a062

Vladis,

thanks for cleaning it up. I actually like your rewrite quite a lot.

Quick question -- how well was it tested in which scenarios?

-- 
Jiri Kosina
SUSE Labs
