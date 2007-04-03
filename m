From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] psmouse: add support for 4th button using the 4th bit
Date: Tue, 3 Apr 2007 10:39:39 -0400
Message-ID: <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com>
References: <20070402204810.GC14838@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070402204810.GC14838@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Aristeu,

On 4/2/07, Aristeu Rozanski <arozansk@redhat.com> wrote:
> Some mice like the Cortron Trackball use the fourth bit of the first byte
> (yes, that one that the protocol tells to be always 1, oh well) to represent
> the fourth button. This patch adds an option to use the fourth bit to
> represent the fourth button.
>
> Please comment on this and please keep me on Cc list, I'm not subscribed to
> linux-input.
>

Do you know if there is a way (like a magic knock) that would allow to
identify Cortron's devices? I don't like the module option too much,
given the fact that it will affect all devices. Maybe we should define
Cortron protocol instead and activate it manually via sysfs?

-- 
Dmitry
