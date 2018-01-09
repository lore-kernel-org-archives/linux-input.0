From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 1/1] input: Deprecate real timestamps beyond year 2106
Date: Mon, 8 Jan 2018 16:32:07 -0800
Message-ID: <20180109003207.hptfbrbhul66pdfp@dtor-ws>
References: <20180107001915.15287-1-deepa.kernel@gmail.com>
 <20180107001915.15287-2-deepa.kernel@gmail.com>
 <20180108215111.tqnhr5k5easbrh4b@dtor-ws>
 <CABeXuvr0a_h5tYbe0_yyUOqnpnqYvvRckyK7GbxNj8JzofY1dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABeXuvr0a_h5tYbe0_yyUOqnpnqYvvRckyK7GbxNj8JzofY1dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 08, 2018 at 04:07:22PM -0800, Deepa Dinamani wrote:
> On Mon, Jan 8, 2018 at 1:51 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Deepa,
> >
> > On Sat, Jan 06, 2018 at 04:19:15PM -0800, Deepa Dinamani wrote:
> >> struct timeval is not y2038 safe.
> >> All usage of timeval in the kernel will be replaced by
> >> y2038 safe structures.
> >> The change is also necessary as glibc is introducing support
> >> for 32 bit applications to use 64 bit time_t. Without this
> >> change, many applications would incorrectly interpret values
> >> in the struct input_event.
> >> More details about glibc at
> >> https://sourceware.org/glibc/wiki/Y2038ProofnessDesign .
> >>
> >> struct input_event maintains time for each input event.
> >> Real time timestamps are not ideal for input as this
> >> time can go backwards as noted in the patch a80b83b7b8
> >> by John Stultz. Hence, having the input_event.time fields
> >> only big enough for monotonic and boot times are
> >> sufficient.
> >
> > I am happy with the patch, but have some concerns about changelog. The
> > change does not really prevent anyone from using CLOCK_REALTIME past
> > 2106, especially on 64 bit arches. We are simply extending range of
> > reported seconds in input event by converting from signed to unsigned
> > value.
> 
> I was interpreting working incorrectly on 32 bit architectures, but
> working correctly on 64 bit architectures as a failure of the feature
> to use realtime clock at all.
> But, you are correct that the patch does not actively do anything to
> stop people from using realtime clock.
> 
> >>
> >> The change leaves the representation of struct input_event as is
> >> on 64 bit architectures. But uses 2 unsigned long values on 32 bit
> >> machines to support real timestamps until year 2106.
> >> This intentionally breaks the ABI on 32 bit architectures and
> >> compat handling on 64 bit architectures.
> >> This is as per maintainer's preference to introduce compile time errors
> >> rather than run into runtime incompatibilities.
> >
> > We are breaking API, not ABI though. The ABI for existing programs is
> > exactly the same, it is only when system starts using the newer glibc
> > supporting extended time the compilation will break.
> 
> I was interpreting not being able to use negative timestamps on 32 bit
> machines as breaking the ABI.
> 
> >> The change requires any 32 bit userspace utilities reading or writing
> >> from event nodes to update their reading format to match the new
> >> input_event. The changes to the popular libraries will be posted once
> >> we agree on the kernel change.
> > I propose we have the following changelog:
> >
> >
> > Input: extend usable life of event timestamps to 2106 on 32 bit systems
> >
> > The input events use struct timeval to store event time, unfortunately
> > this structure is not y2038 safe and is being replaced in kernel with
> > y2038 safe structures.
> >
> > Because of ABI concerns we can not change the size or the layout of
> > structure input_event, so we opt to re-interpreting the 'seconds' part
> > of timestamp as an unsigned value, effectively doubling the range of
> > values, to year 2106.
> > Newer glibc that has support for 32 bit applications to use 64 bit
> > time_t supplies __USE_TIME_BITS64 define [1], that we can use to present
> > the userspace with updated input_event layout. The updated layout will
> > cause the compile time breakage, alerting applications and distributions
> > maintainers to the issue. Existing 32 binaries will continue working
> > without any changes until 2038.
> >
> > Ultimately userspace applications should switch to using monotonic or
> > boot time clocks, as realtime clock is not very well suited for input
> > event timestamps as it can go backwards (see a80b83b7b8 "Input: evdev -
> > add CLOCK_BOOTTIME support" by by John Stultz). With monotonic clock the
> > practical range of reported times will always fit into the pair of 32
> > bit values, as we do not expect any system to stay up for a hundred
> > years without a single reboot.
> >
> > [1] https://sourceware.org/glibc/wiki/Y2038ProofnessDesign
> >
> >
> > Please let me know if you disagee with the above.
> 
> I'm fine with this commit text. Let me know if you would like me to update this.

No, unless somebody yells I'll change it on my side.

Thanks.

-- 
Dmitry
