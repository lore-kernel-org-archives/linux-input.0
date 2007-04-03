From: Aristeu Rozanski <arozansk@redhat.com>
Subject: Re: [RFC] psmouse: add support for 4th button using the 4th bit
Date: Tue, 3 Apr 2007 11:23:36 -0400
Message-ID: <20070403152336.GF14838@redhat.com>
References: <20070402204810.GC14838@redhat.com> <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com> <20070403144243.GE14838@redhat.com> <d120d5000704030805l397a61d5x99b8fdb138b6881d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000704030805l397a61d5x99b8fdb138b6881d@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

> That's unfortunate. BTW, is this your observation or did you ask
> Cortron and this was their response?
The customer got in touch with Cortron about this and Cortron told it's not
possible to detect it. I can try talking with them to make sure it's the
case.

> You'd need to add something like this to psmouse_protocols[]:
> 
>        {
>                .type           = PSMOUSE_CORTRON,
>                .name           = "CortronPS/2",
>                .alias          = "cortps",
>                .detect         = cortron_detect,
>        },
> 
> and then model cortron_detect after ps2bare_detect (where you don't
> actually detect anything, just force protocol).
ok!
Thanks,

-- 
Aristeu
