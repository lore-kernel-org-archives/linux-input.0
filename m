From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/2 v2] Input: synaptics - add sysfs access to firmware
 ID & board ID
Date: Wed, 4 Jul 2012 15:08:48 +0200
Message-ID: <20120704130848.GA316@polaris.bitmath.org>
References: <1341392837-19115-1-git-send-email-djkurtz@chromium.org>
 <1341392837-19115-2-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1341392837-19115-2-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 04, 2012 at 05:07:17PM +0800, Daniel Kurtz wrote:
> Allow userspace to query firmware ID and board ID, which are read and
> cached during device initialization.
> 
> This information can be read, for instance, by a userspace feedback
> reporting tool, to include this information in its reports.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/input/mouse/synaptics.c |   41 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 41 insertions(+), 0 deletions(-)

Still reluctant here, but I am fine with whatever Dmitry thinks about it.

Thanks.
Henrik
