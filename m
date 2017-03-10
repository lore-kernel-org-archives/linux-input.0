From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - add ASUS EeeBook X205TA special
 touchpad fw
Date: Fri, 10 Mar 2017 14:36:28 -0800
Message-ID: <20170310223628.GA4059@dtor-ws>
References: <1488679982-9825-1-git-send-email-matjaz.hegedic@gmail.com>
 <20170306195442.GC30488@dtor-ws>
 <00b601d29711$302c1800$90844800$@emc.com.tw>
 <5b8ea500-0269-b3c7-1a54-af6bfd18b640@gmail.com>
 <008e01d297d5$82d1c720$88755560$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <008e01d297d5$82d1c720$88755560$@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: =?utf-8?B?J01hdGphxb4gSGVnZWRpxI0n?= <matjaz.hegedic@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?B?J+m7g+S4lum1rCDntpPnkIYn?= <phoenix@emc.com.tw>, miller_wang@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Wed, Mar 08, 2017 at 02:30:42PM +0800, 廖崇榮 wrote:
> Hi Matjaz,
> 
> -----Original Message-----
> From: Matjaž Hegedič [mailto:matjaz.hegedic@gmail.com] 
> Sent: Tuesday, March 07, 2017 6:52 PM
> To: 廖崇榮; 'Dmitry Torokhov'
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; 黃世鵬 經理; miller_wang@emc.com.tw
> Subject: Re: [PATCH] Input: elan_i2c - add ASUS EeeBook X205TA special touchpad fw
> 
> Hi Dmitry, KT!
> 
> On 2017-03-07 08:05, 廖崇榮 wrote:
> > Hi Dmitry
> >
> > -----Original Message-----
> > From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> > Sent: Tuesday, March 07, 2017 3:55 AM
> > To: KT Liao
> > Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Matjaz 
> > Hegedic
> > Subject: Re: [PATCH] Input: elan_i2c - add ASUS EeeBook X205TA special 
> > touchpad fw
> >
> > On Sun, Mar 05, 2017 at 03:13:02AM +0100, Matjaz Hegedic wrote:
> >> EeeBook X205TA is yet another ASUS device with a special touchpad 
> >> firmware that needs to be accounted for during initialization, or 
> >> else the touchpad will go into an invalid state upon suspend/resume.
> >> Adding the appropriate ic_type and product_id check fixes the problem.
> >
> > KT, does this look reasonable? Are there more ASUS models that need 
> > such handling?
> > [KT] : I just discuss it with FW team.
> > We can't confirm it right now because it's an old product. And the 
> > solution focus on power-on issue, not suspend/resume.
> > I will let you know once we figure it out.
> >
> > Our FW has modified, the issue should not happen on new models.
> >
> > Thanks		KT
> 
> As it is now, the touchpad will stop working upon resume, returning an invalid id (and requires a cumbersome workaround of reloading the module). As the touchpad FW is opaque to me, the only way I could resolve the bug was through trial-and-error. Including the touchpad in the 'special fw' resolves the bug and the touchpad resumes without issue.
> 
> Now, even if the function is indeed used to resolve a different issue on other ASUS touchpads, I would argue that this is the most pragmatic way of resolving the problem on X205TA, X205TAW and F205TA (and possibly also X200HA & X206HA, though I don't have those to test).
> 
> It shouldn't affect any other models or touchpad products.
> 
> Thanks!
> 
> I agree your opinion.
> The special handle simply changes the sequence of commands and adds delay cycle. 
> It is harmless to general Elan products but rescue control flaws in some FW.
> 
> Thanks		KT

OK, I added KT as Acked-by and marked for stable.

Thanks.

-- 
Dmitry
