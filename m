From: Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ISH firmware loader client driver
Date: Fri, 29 Mar 2019 01:49:44 +0530
Message-ID: <20190328201943.GA17404@intel.com>
References: <1553339772-25012-1-git-send-email-rushikesh.s.kadam@intel.com>
 <31755c704928710da998353192157ddfd903080c.camel@linux.intel.com>
 <CAHX4x87iQgjX8wHOYNCD7nYQJZKoirgCimPax11bMX_DGMEudw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHX4x87iQgjX8wHOYNCD7nYQJZKoirgCimPax11bMX_DGMEudw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Crews <ncrews@chromium.org>
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, jettrink@chromium.org, gwendal@google.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Hi Nick
Thanks once again for your time.

I've addressed majority of the comments below.
Will send a v2 shortly. Please see my replies
inline below.

On Tue, Mar 26, 2019 at 06:39:14PM -0600, Nick Crews wrote:
> Hi Rushikesh, I know I've been reviewing this on Chromium, but I have
> some more larges-scale design thoughts.
> 
> > > diff --git a/drivers/hid/intel-ish-hid/ishtp-fw-loader.c
> > > b/drivers/hid/intel-ish-hid/ishtp-fw-loader.c

> > > +/**
> > > + * report_bad_packets() Report bad packets
> > > + * @loader_ishtp_cl: Client instance to get stats
> > > + * @recv_buf:                Raw received host interface message
> > > + *
> > > + * Dumps error in case bad packet is received
> > > + */
> > > +static void report_bad_packet(struct ishtp_cl *loader_ishtp_cl,
> > > +                           void *recv_buf)
> > > +{
> > > +     struct loader_msg_hdr *hdr = recv_buf;
> > > +     struct ishtp_cl_data *client_data =
> > > +             ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     client_data->bad_recv_cnt++;
> > > +     dev_err(cl_data_to_dev(client_data),
> > > +             "BAD packet: command=%02lx is_response=%u status=%02x
> > > total_bad=%u\n",
> > > +             hdr->command & CMD_MASK,
> > > +             hdr->command & IS_RESPONSE ? 1 : 0,
> > > +             hdr->status,
> > > +             client_data->bad_recv_cnt);
> > > +}
> 
> I would remove this function. Whenever you call it, you already have
> use dev_err() to print the reason for the error. Consider removing
> bad_rcv_count too unless you do something with it other than debugging.

> 
> At the very least, you call this function when the ISH doesn't return enough
> data, but in here you try to access the fields in hdr. This could be accessing
> irrelevant/illegal data.
> 
> Also a nit: The docstring function name has a naughty trailing s.

I think I'll take your inputs to drop this
function.

> 
> > > +
> > > +/**
> > > + * loader_ish_hw_reset() - Reset ISH HW in bad state
> > > + * @loader_ishtp_cl  Client instance to reset
> > > + *
> > > + * This function resets ISH hardware, which shall reload
> > > + * the Shim firmware loader, initiate ISH-TP interface reset,
> > > + * re-attach kernel loader driver, and repeat Host
> > > + * firmware load.
> > > + */
> > > +static inline void loader_ish_hw_reset(struct ishtp_cl
> > > *loader_ishtp_cl)
> > > +{
> > > +     struct ishtp_cl_data *client_data =
> > > +             ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     dev_warn(cl_data_to_dev(client_data), "Reset the ISH
> > > subsystem\n");
> > > +     ish_hw_reset(ishtp_get_ishtp_device(loader_ishtp_cl));
> > > +}
> 
> Delete this as a function. Before you actually called it in multiple places,
> but now i's only called in one place, so just inline it there.

Will drop this function as well.

> 
> > > +
> > > +/**
> > > + * loader_cl_send()  Send message from host to firmware
> > > + * @client_data:     Client data instance
> > > + * @msg                      Message buffer to send
> > > + * @msg_size         Size of message
> > > + *
> > > + * Return: Received buffer size on success, negative error code on
> > > failure.
> > > + */
> > > +static int loader_cl_send(struct ishtp_cl_data *client_data,
> > > +                       u8 *msg, size_t msg_size)
> > > +{
> > > +     int rv;
> > > +     size_t data_len;
> > > +     struct loader_msg_hdr *in_hdr;
> > > +     struct loader_msg_hdr *out_hdr = (struct loader_msg_hdr *)msg;
> > > +     struct ishtp_cl *loader_ishtp_cl = client_data-
> > > >loader_ishtp_cl;
> > > +
> > > +     dev_dbg(cl_data_to_dev(client_data),
> > > +             "%s: command=%02lx is_response=%u status=%02x\n",
> > > +             __func__,
> > > +             out_hdr->command & CMD_MASK,
> > > +             out_hdr->command & IS_RESPONSE ? 1 : 0,
> > > +             out_hdr->status);
> > > +
> > > +     client_data->flag_response = false;
> > > +     rv = ishtp_cl_send(loader_ishtp_cl, msg, msg_size);
> > > +     if (rv < 0) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "ishtp_cl_send error %d\n", rv);
> > > +             return rv;
> > > +     }
> > > +
> > > +     wait_event_interruptible_timeout(client_data->cmd_resp_wait,
> > > +                                      client_data->flag_response,
> > > +                                      ISHTP_SEND_TIMEOUT);
> > > +     if (!client_data->flag_response) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Timed out for response to command=%02lx",
> > > +                     out_hdr->command & CMD_MASK);
> > > +             return -ETIMEDOUT;
> > > +     }
> > > +
> > > +     /* All response messages will contain a header */
> > > +     data_len = client_data->response_size;
> > > +     in_hdr = (struct loader_msg_hdr *)client_data->response_data;
> 
> If process_recv() fails then client_data->response_data could be NULL.
> This brings up the question of what to do if process_recv() fails. I would think
> that you would want it to set something like client_data->response_error
> and then you could check for that in here and return it. For instance
> right now if the ISH
> doesn't return sizeof(struct loader_msg_hdr) bytes then it would be nice to get
> -EMSGSIZE returned from here.

If the process_recv() fails, the flag_response
stays false. We check for the flag in calling
function and exit, so won't be accessing null
data.

But I do like your idea to add a resposne_error
field to pass the error to the calling function.
Will do so.

> 
> > > +
> > > +     /* Sanity checks */
> > > +     if (!(in_hdr->command & IS_RESPONSE)) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Invalid response to command\n");
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     if (in_hdr->status) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "Loader returned status %d\n",
> > > +                     in_hdr->status);
> > > +             return -EIO;
> > > +     }
> > > +
> > > +     return data_len;
> > > +}
> 
> So I think how you've changed this to handle where the data is stored is good,
> but it could be better. I don't like how the users of loader_cl_send() need to
> remember to kfree(client_data->response data), and that they just implicitly
> assume that client_data->response data holds the result. Instead, make the
> callers of loader_cl_send() allocate a buffer to hold the result, and then the
> allocating and freeing happens in the same function. I think this is a much more
> understandable form of memory management.

Agreed

> 
> How about this function turns into:
> /**
>  * loader_cl_send()  Send message from host to firmware
>  * @client_data: Client data instance
>  * @in_data: Message buffer to send
>  * @in_size: Size of sent data
>  * @out_data: Buffer to fill with received data.
>  * @out_size: Max number of bytes to place in out_data.
>  *
>  * Return: Number of bytes placed into out_data, negative error code on failure.
>  */

Sounds good. One comment - should the names
out_msg & in_msg be interchanged? As in, the
message from AP to firmware be out_msg, and
firwmare to AP should be in_msg? 

> static int loader_cl_send(struct ishtp_cl_data *client_data,
>                                         u8 *in_data, size_t in_size,
>                                         u8 *out_data, size_t out_size)
> 
> {
> client_data->response_data = out_data;
> client_data->response_size_max = out_size;
> 
> Send the command.
> Tweak process_recv() so where it does the memcpy() into
> client_data->response_data,
> add the additional check to make sure it doesn't copy more than
> client_data->response_size_max bytes.
> Wait for the completion flag.
> Continue with the rest.
> }
> 
> With these suggestions there are now six pieces of info getting
> transmitted between
> process_recv() and loader_cl_send() via client data:
> client_data->cmd_resp_wait
> client_data->flag_response
> client_data->response_error
> client_data->response_size
> client_data->response_size_max
> client_data->response_data
> Consider turning these into:
> client_data->response_info->wait_queue
> client_data->response_info->data_available // or some better name?
> client_data->response_info->error
> client_data->response_info->size
> client_data->response_info->size_max
> client_data->response_info->data
> for some encapsulation?

Will do.

> 
> I'm thinking about this more, and basically it seems like we're
> writing a library function to
> send a command to the ISH and receive a response. All the clients who
> use loader_cl_send()
> shouldn't know about the client_data->response_info stuff at all. It
> almost seems like this
> entire functionality should be part of the ISH core? It's really
> limiting that ishtp_cl_send() only
> allows sending and no receiving! It should?!
>

The way I see it is that the loader_cl_send() is
an application specific implementation. We make
assumptions here about the header (command,
is_response, status fields), and that all command
& response are serialized. Also this works well
when the response buffer is small, and we don't
mind copying content vs. passing pointer.

On the other hand, the ISH core provides a basic
but generic interface for ishtp_cl_send() and for
managing ring buffers.

If we could "standardize" loader_cl_send() and use
in more applications (such as upcoming driver for
cros_ec over ishtp), we may have a case to add as
a core function. I'll keep it in this driver for
the next revision (coming shortly). I'm open to
further discussion.

> > > +
> > > +/**
> > > + * process_recv() -  Receive and parse incoming packet
> > > + * @loader_ishtp_cl: Client instance to get stats
> > > + * @rb_in_proc:              ISH received message buffer
> > > + *
> > > + * Parse the incoming packet. If it is a response packet then it
> > > will
> > > + * update flag_response and wake up the caller waiting to for the
> > > response.
> > > + */
> > > +static void process_recv(struct ishtp_cl *loader_ishtp_cl,
> > > +                      struct ishtp_cl_rb *rb_in_proc)
> > > +{
> > > +     size_t data_len = rb_in_proc->buf_idx;
> > > +     struct loader_msg_hdr *hdr =
> > > +             (struct loader_msg_hdr *)rb_in_proc->buffer.data;
> > > +     struct ishtp_cl_data *client_data =
> > > +             ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     /*
> > > +      * All firmware messages have a header. Check buffer size
> > > +      * before accessing elements inside.
> > > +      */
> > > +     if (data_len < sizeof(struct loader_msg_hdr)) {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "data size %zu is less than header %zu\n",
> > > +                     data_len, sizeof(struct loader_msg_hdr));
> > > +             report_bad_packet(client_data->loader_ishtp_cl, hdr);
> > > +             goto end_error;
> > > +     }
> > > +
> > > +     dev_dbg(cl_data_to_dev(client_data),
> > > +             "%s: command=%02lx is_response=%u status=%02x\n",
> > > +             __func__,
> > > +             hdr->command & CMD_MASK,
> > > +             hdr->command & IS_RESPONSE ? 1 : 0,
> > > +             hdr->status);
> > > +
> > > +     switch (hdr->command & CMD_MASK) {
> > > +     case LOADER_CMD_XFER_QUERY:
> > > +     case LOADER_CMD_XFER_FRAGMENT:
> > > +     case LOADER_CMD_START:
> > > +             /* Sanity check */
> > > +             if (client_data->response_data || client_data-
> > > >flag_response) {
> 
> Following advice above, how about checking
> client_data->response_info->data_available instead?
> Or with advice above, corrupting old data might not be an issue,
> since the destination buffer changes? Also I wouldn't call this a buffer
> overrun below, it's a different problem.

I think I'll keep the check because even though
we may not be corrupting the buffer from the
previous call, it's still a bug that we got here
before processing the previous call.

> > > +/**
> > > + * loader_cl_event_cb() - bus driver callback for incoming message
> > > + * @device:          Pointer to the the ishtp client device for
> > > which
> > > + *                   this message is targeted
> > > + *
> > > + * Remove the packet from the list and process the message by
> > > calling
> > > + * process_recv
> > > + */
> > > +static void loader_cl_event_cb(struct ishtp_cl_device *cl_device)
> > > +{
> > > +     struct ishtp_cl_rb *rb_in_proc;
> > > +     struct ishtp_cl_data *client_data;
> > > +     struct ishtp_cl *loader_ishtp_cl =
> > > ishtp_get_drvdata(cl_device);
> > > +
> > > +     client_data = ishtp_get_client_data(loader_ishtp_cl);
> > > +
> > > +     while ((rb_in_proc = ishtp_cl_rx_get_rb(loader_ishtp_cl)) !=
> > > NULL) {
> > > +             if (!rb_in_proc->buffer.data) {
> > > +                     dev_warn(cl_data_to_dev(client_data),
> > > +                              "rb_in_proc->buffer.data returned
> > > null");
> 
> Maybe move this check into process_recv() and then you can set
> client_data->response_info->error for it?

Will do.

> 
> > > +                     continue;
> > > +             }
> > > +
> > > +             /* Process the data packet from firmware */
> > > +             process_recv(loader_ishtp_cl, rb_in_proc);
> > > +     }
> > > +}
> > > +
> > > +/**
> > > + * ish_query_loader_prop() -  Query ISH Shim firmware loader
> > > + * @client_data:     Client data instance
> > > + * @fw:                      Poiner to fw data struct in host memory
> > > + *
> > > + * This function queries the ISH Shim firmware loader for
> > > capabilities.
> > > + *
> > > + * Return: 0 for success, negative error code for failure.
> > > + */
> > > +static int ish_query_loader_prop(struct ishtp_cl_data *client_data,
> > > +                              const struct firmware *fw,
> > > +                              struct shim_fw_info *fw_info)
> > > +{
> > > +     int rv;
> > > +     size_t data_len;
> > > +     struct loader_msg_hdr *hdr;
> > > +     struct loader_xfer_query ldr_xfer_query;
> > > +     struct loader_xfer_query_response *ldr_xfer_query_resp;
> > > +
> > > +     memset(&ldr_xfer_query, 0, sizeof(ldr_xfer_query));
> > > +     ldr_xfer_query.hdr.command = LOADER_CMD_XFER_QUERY;
> > > +     ldr_xfer_query.image_size = fw->size;
> > > +     rv = loader_cl_send(client_data,
> > > +                         (u8 *)&ldr_xfer_query,
> > > +                         sizeof(ldr_xfer_query));
> > > +     if (rv < 0) {
> > > +             client_data->flag_retry = true;
> > > +             goto end_error;
> > > +     }
> > > +
> > > +     /* Check buffer size before accessing the elements */
> > > +     data_len = client_data->response_size;
> 
> Use rv instead of client_data->response_size, we want to minimize weird
> unexplainable accesses of the fileds of client_data.


> Also consider not using the variable data_len, it doesn't do too much besides
> cause some indirection. With the change above it should be obvious
> what is going on.

I felt using data_len makes the code a bit easier
to read because it reminds the reader that the
returned value is the length of the received
buffer. But I'll make the change :)

> > > +     release_firmware(fw);
> > > +     kfree(filename);
> > > +     dev_info(cl_data_to_dev(client_data), "ISH firmware %s
> > > loaded\n",
> > > +              filename);
> > > +     return 0;
> > > +
> > > +end_err_fw_release:
> > > +     release_firmware(fw);
> > > +end_err_filename_buf_release:
> > > +     kfree(filename);
> > > +end_error:
> > > +     if (client_data->flag_retry) {
> > > +             dev_warn(cl_data_to_dev(client_data),
> > > +                      "ISH host firmware load failed %d. Reset ISH &
> > > try again..\n",
> > > +                      rv);
> > > +             loader_ish_hw_reset(client_data->loader_ishtp_cl);
> 
> This could just keep failing infinitely, right? Do you want to add
> some retry counter,
> and after some limit then give up or something? What happens if the ISH firmware
> never succeeds in loading?

I'll add 3 attempts before we fail.

> 
> > > +     } else {
> > > +             dev_err(cl_data_to_dev(client_data),
> > > +                     "ISH host firmware load failed %d\n", rv);
> > > +     }
> > > +     return rv;
> > > +}
> 
> And there were many typos in comments that I saw, comb through them
> carefully again.

Let me scrub for them again.

> 
> Cheers,
> Nick

Thanks
Rushikesh


-- 
