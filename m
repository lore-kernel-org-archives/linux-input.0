From: Aristeu Rozanski <arozansk@redhat.com>
Subject: Re: [RFC] psmouse: add support for 4th button using the 4th bit
Date: Tue, 3 Apr 2007 10:42:43 -0400
Message-ID: <20070403144243.GE14838@redhat.com>
References: <20070402204810.GC14838@redhat.com> <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Dmitry,
> Do you know if there is a way (like a magic knock) that would allow to
> identify Cortron's devices? I don't like the module option too much,
> given the fact that it will affect all devices. Maybe we should define
> Cortron protocol instead and activate it manually via sysfs?
there's no way to detect this Cortron device, it was my first try. Hm, the
new protocol/sysfs idea seems to be much better, I didn't know that was
possible. I'll rework the patch and resubmit.
Thanks!

-- 
Aristeu
