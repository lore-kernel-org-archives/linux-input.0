From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] iforce: Use usb_kill_urb instead of usb_unlink_urb.
Date: Sat, 17 Mar 2007 21:37:22 -0400
Message-ID: <200703172137.23385.dtor@insightbb.com>
References: <38b3b7c0703171439n10025a7bx55a588911eb765d6@mail.gmail.com> <38b3b7c0703171443j2f50f913r76ab111ba7ed109f@mail.gmail.com> <38b3b7c0703171450q5217f4eer91e7ba0f6135d98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0703171450q5217f4eer91e7ba0f6135d98@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

Hi Johann,

On Saturday 17 March 2007 17:50, johann deneux wrote:
> A note about that patch: Apparently Anders Fugmann submitted a patch to use
> usb_kill_urb to linux-usb-devel for version 2.6.10.
> I don't know if this patch got lost, or if it was rejected.

Since every other USB dirver uses usb_kill_urb it loosk like the patch was
just missed...
 
> 
> On 3/17/07, johann deneux <johann.deneux@gmail.com> wrote:
> >
> > commit 0ba8785483c2ee7f56e8f242e000f6cd17a7da40
> > Author: Johann Deneux <johann.deneux@gmail.com>
> > Date:   Sat Mar 17 22:23:44 2007 +0100
> >
> >     iforce: Use usb_kill_urb instead of usb_unlink_urb.
> >
> >     Using usb_unlink_urb can cause iforce_open to fail when called soon
> > after iforce_release.
> >     Also updated my email address and replaced calls to printk() by dbg(),
> > warn(), info(), err()...
> >

Since there seems a lot of implementations of r warn(), err(), etc what kind
of output would iforce produce?

-- 
Dmitry
