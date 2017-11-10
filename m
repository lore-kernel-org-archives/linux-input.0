From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 2/5] platform/x86: intel-vbtn: Support separate
 press/release events
Date: Thu, 9 Nov 2017 18:11:37 -0800
Message-ID: <20171110021137.GE9783@fury>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <024c7574-12f2-4708-9f90-1192856df401@rwthex-w2-a.rwth-ad.de>
 <20171110013417.GB9783@fury>
 <1637751.MqEGyCB5Qi@pebbles>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1637751.MqEGyCB5Qi@pebbles>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Nov 10, 2017 at 02:58:36AM +0100, Stefan Brüns wrote:
> On Friday, November 10, 2017 2:34:17 AM CET Darren Hart wrote:
> > On Thu, Nov 09, 2017 at 11:44:33PM +0100, Stefan Brüns wrote:
> > > Currently all key events use autorelease, but this forbids use as a
> > > modifier key.
> > > 
> > > As all event codes come in even/odd pairs, we can lookup the key type
> > > (KE_KEY/KE_IGNORE) for the key up event corresponding to the currently
> > > handled key down event. If the key up is ignored, we keep setting the
> > > autorelease flag for the key down.
> > 
> > What is the use-case for using these buttons as modifiers? I'm picturing one
> > of these devices in tablet mode, with a physical Windows button. What other
> > action does a user want to modify by holding the Windows button down? Or is
> > there another scenario we're trying to support here?
> 
> Windows/KEY_LEFTMETA can be used as a modifier key, e.g. in combination with 
> the Volume Up/Down keys. On Windows, the default for Win + VolumeUp creates a 
> screenshot.
> 
> You can also use this in combination with an onscreen keyboard. Pressing the 
> hardware button with the hand holding the tablet and typing with the other 
> hand on the OSK is probably easier than hitting both keys on the OSK.

This all makes sense - good context for the commit message. If no other changes
end up being needed, I'm happy to paste it in at merge. If changes are required,
please add it in v3.

> 
> Additionally, the Volume Up/Down currently do not autorepeat, as the key is
> autoreleased on the press event. The XPS 12 does issue distinct press/release 
> events, so this could be done properly. The same apparently holds for some 
> other convertibles, see the links in Patch 1/5.

It sounds like this is spotty across intel-vbtn implementations? Some devices
emit release, others do not? How would you teach the driver about the
differences? Assume autorelease and change the sparse keymap entry for DMI
matched platforms with release? Doable... sounds unpleasant to maintain and
update. Do we support this fully in userspace already?

-- 
Darren Hart
VMware Open Source Technology Center
