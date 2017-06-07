From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 13/16] hid: intel-ish-hid: use dev_groups and not dev_attrs
 for bus_type
Date: Wed, 7 Jun 2017 15:40:32 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706071539580.30709@cbobk.fhfr.pm>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org> <20170606192221.1617-14-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51867 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751739AbdFGNkk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 7 Jun 2017 09:40:40 -0400
In-Reply-To: <20170606192221.1617-14-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wei Yongjun <weiyj.lk@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-input@vger.kernel.org

On Tue, 6 Jun 2017, Greg Kroah-Hartman wrote:

> The dev_attrs field has long been "depreciated" and is finally being
> removed, so move the driver to use the "correct" dev_groups field
> instead for struct bus_type.
> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Wei Yongjun <weiyj.lk@gmail.com>
> Cc: Bhumika Goyal <bhumirks@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: <linux-input@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs

