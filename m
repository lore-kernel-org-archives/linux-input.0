From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] tc3589x OF only enforcement
Date: Fri, 27 Mar 2015 09:48:25 -0700
Message-ID: <20150327164825.GB17364@dtor-ws>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZC-+fZXRAqnir2+pyq-es=-zA9jS2qGUiOF75KqzSLqQ@mail.gmail.com>
 <20150327120033.GF15988@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150327120033.GF15988@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Mar 27, 2015 at 12:00:33PM +0000, Lee Jones wrote:
> On Fri, 27 Mar 2015, Linus Walleij wrote:
> 
> > On Thu, Mar 19, 2015 at 3:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > 
> > > These two patches removes the non-DT probe/config path from the
> > > TC3589x driver. I suggest merging both through the MFD tree if
> > > Dmitry can ACK the input patch.
> > 
> > Lee it seems Dmitry ACKed these patches, can you merge those
> > two patches into MFD? I don't think there will be any cross-tree deps
> > so you can just carry them  in MFD without any immutable branch business.
> 
> Change of plan.  20f02d6 scuppers you plans unfortunately.  Probably
> best if this goes in via the Input tree.

OK, I'm taking them then...

Thanks.

-- 
Dmitry
