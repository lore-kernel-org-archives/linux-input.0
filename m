From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4/8] HID: sony: Report DS4 motion sensors through a
 separate device
Date: Fri, 27 Jan 2017 14:50:27 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701271449020.25515@cbobk.fhfr.pm>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com> <1479938833-26424-5-git-send-email-roderick@gaikai.com> <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org> <CANndSK=vwg6bTL1RCCaFRYQ9aJX_kQ47g-x6jJR_hHrPLnVH+w@mail.gmail.com>
 <alpine.LNX.2.00.1611281452280.29400@cbobk.fhfr.pm> <CANndSKkq4WnXi7Fsm+OT0U1=1uz1ZwMNq_4ZOuuvu-uxEnhuOw@mail.gmail.com> <CANndSKno77dbXgop=nvbfL3ABBjB2TrHvV9BfvHTaiM+KiqH4g@mail.gmail.com> <20161205094455.GN1280@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932269AbdA0Nuc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 08:50:32 -0500
In-Reply-To: <20161205094455.GN1280@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Roderick Colenbrander <roderick@gaikai.com>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Mon, 5 Dec 2016, Benjamin Tissoires wrote:

> In your case, I think using IIO is just non sense. The accelerometers 
> found on the DS4 are meant to be used as a stream of data, which is not 
> what IIO was made for. Plus, if you start exporting accelerometers as 
> IIO, how will the DE differentiate between the DS4 accelerometer and the 
> integrated one.

Fair enough, after re-reading the whole thing, I agree that IIO is not the 
best aproach here. So let's just proceed as originally planned.

Thanks,

-- 
Jiri Kosina
SUSE Labs

