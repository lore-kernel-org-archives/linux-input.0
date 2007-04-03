From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] psmouse: add support for 4th button using the 4th bit
Date: Tue, 3 Apr 2007 11:05:13 -0400
Message-ID: <d120d5000704030805l397a61d5x99b8fdb138b6881d@mail.gmail.com>
References: <20070402204810.GC14838@redhat.com>
	 <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com>
	 <20070403144243.GE14838@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070403144243.GE14838@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 4/3/07, Aristeu Rozanski <arozansk@redhat.com> wrote:
> Hi Dmitry,
> > Do you know if there is a way (like a magic knock) that would allow to
> > identify Cortron's devices? I don't like the module option too much,
> > given the fact that it will affect all devices. Maybe we should define
> > Cortron protocol instead and activate it manually via sysfs?
> there's no way to detect this Cortron device, it was my first try.

That's unfortunate. BTW, is this your observation or did you ask
Cortron and this was their response?

> Hm, the
> new protocol/sysfs idea seems to be much better, I didn't know that was
> possible. I'll rework the patch and resubmit.

You'd need to add something like this to psmouse_protocols[]:

        {
                .type           = PSMOUSE_CORTRON,
                .name           = "CortronPS/2",
                .alias          = "cortps",
                .detect         = cortron_detect,
        },

and then model cortron_detect after ps2bare_detect (where you don't
actually detect anything, just force protocol).

-- 
Dmitry
