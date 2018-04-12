From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/4] HID: alps: Fix some bugs and improve code around
 't4_read_write_register()'
Date: Thu, 12 Apr 2018 15:11:02 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1804121510340.28129@cbobk.fhfr.pm>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr> <nycvar.YFH.7.76.1803271405420.15778@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1803271405420.15778@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: masaki.ota@jp.alps.com, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 27 Mar 2018, Jiri Kosina wrote:

> > These patches are untested. Especially, patch 1 slightly changes the behavior
> > of 't4_read_write_register()'.
> > This looks logical to me, but please, review it carefully.
> > 
> > Christophe JAILLET (4):
> >   HID: alps: Report an error if we receive invalid data in
> >     't4_read_write_register()'
> >   HID: alps: Save a memory allocation in 't4_read_write_register()' when
> >     writing data
> >   HID: alps: Check errors returned by 't4_read_write_register()'
> >   HID: alps: Fix some style in 't4_read_write_register()'
> > 
> >  drivers/hid/hid-alps.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> Masaki-san,
> 
> do you have any comments to Christophe's patchset please?

If there is no feedback, I'll queue the set for 4.18.

Thanks,

-- 
Jiri Kosina
SUSE Labs
