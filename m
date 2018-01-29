From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 4/8] Input: mms114 - remove unused variable
Date: Tue, 30 Jan 2018 08:27:52 +0900
Message-ID: <20180129232752.GV7575@gangnam.samsung>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p3bb7bc89558e7219ef257b36fa47dc076@epcas2p3.samsung.com>
        <20180129113323.18961-5-andi.shyti@samsung.com>
        <20180129184309.ljnw63owyuhofqko@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20180129184309.ljnw63owyuhofqko@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, Jan 29, 2018 at 10:43:09AM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 29, 2018 at 08:33:19PM +0900, Andi Shyti wrote:
> > '__packed' is not used anywhere, remove it.
> 
> Umm, this is not a variable, this is type annotation meaning that the
> structure is packed. Still not needed, as we are not using anything but
> u8 data elements, but justification is completely wrong.

Oh dammit! :)

of course! The original idea was the alignment of the structure,
but I must have got confused while re-editing all the commits.

Sorry, I'll fix it.

Andi
