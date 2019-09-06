From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable 5.2/4.19] Revert "Input: elantech - enable SMBus
 on new (2018+) systems"
Date: Fri, 6 Sep 2019 11:53:47 +0200
Message-ID: <20190906095347.GC16843@kroah.com>
References: <20190906085345.26279-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190906085345.26279-1-benjamin.tissoires@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 06, 2019 at 10:53:45AM +0200, Benjamin Tissoires wrote:
> This reverts commit 60956b018bfe23b879405a7d88103d0a8f06a5e3.
> 
> This patch depends on an other series:
> https://patchwork.kernel.org/project/linux-input/list/?series=122327&state=%2A&archive=both
> 
> It was a mistake to backport it in the v5.2 branch, as there
> is a high chance we encounter a touchpad that needs the series
> above.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204733
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204771
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> Hi,
> 
> this is a stable only patch aimed at kernels v5.2 and v4.19 branches.
> 
> We already have 2 bug reports of a failing touchpad, and I don't think
> it is worth trying to get a smoother touchpad if we randomly
> break a few of them in the way.

Now reverted, I'll push out some new releases with that now so people's
machines get back to a working state.

thanks,

greg k-h
