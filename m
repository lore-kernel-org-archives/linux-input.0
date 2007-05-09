From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] psmouse: add support for 4th button using the 4th bit
Date: Wed, 9 May 2007 10:36:57 -0400
Message-ID: <d120d5000705090736p145b6a7cn8645eccdb5c35ca3@mail.gmail.com>
References: <20070402204810.GC14838@redhat.com>
	 <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com>
	 <20070403144243.GE14838@redhat.com>
	 <d120d5000704030805l397a61d5x99b8fdb138b6881d@mail.gmail.com>
	 <20070508185327.GB4215@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070508185327.GB4215@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Chris Williams <cww@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi Aristeu,

On 5/8/07, Aristeu Rozanski <arozansk@redhat.com> wrote:
> Hi Dmitry,
> > You'd need to add something like this to psmouse_protocols[]:
> >
> >        {
> >                .type           = PSMOUSE_CORTRON,
> >                .name           = "CortronPS/2",
> >                .alias          = "cortps",
> >                .detect         = cortron_detect,
> >        },
> >
> > and then model cortron_detect after ps2bare_detect (where you don't
> > actually detect anything, just force protocol).
> we asked Cortron again about a possible auto-detection sequence but they
> didn't implemented anything in this matter. So I updated the patch
> according your recomendations and Chris tested again with the Trackball,
> with success. If you're ok with that, I'll resubmit it with proper
> description/signed-off-by header.
>

Looks good, please resend. There may be issues with box losing
manually set protocols when coming out of suspend but that's for
another patch.

Thank you.

-- 
Dmitry
