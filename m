From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Date: Thu, 23 Aug 2018 11:57:22 -0700
Message-ID: <20180823185722.GA24777@bombadil.infradead.org>
References: <20180823183057.247630-1-hcutts@chromium.org>
 <20180823183057.247630-2-hcutts@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180823183057.247630-2-hcutts@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Cutts <hcutts@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Kosina <jiri.kosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 23, 2018 at 11:30:55AM -0700, Harry Cutts wrote:
> +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> +    distance travelled by the user's finger, in 256ths of a millimeter.

Is it too late to change this to an actual unit like micrometres?
